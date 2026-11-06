"""Compile the parsed NTT modules to native GML and resumable basic blocks.

This compiler deliberately has no 'ignore unsupported' fallback. It emits a
source map and dependency inventory; runtime adapters must be implemented and
verified before the generated modules can be enabled in the playable project.
"""
from dataclasses import asdict
from pathlib import Path
import json
import re

from fr_gml_parser import Node, parse_inventory
from fr_runtime_schema import API, FIELD_ALIASES, GAMECONT_FIELD_ALIASES, SCALED_FIELDS, module_key

ROOT = Path(__file__).resolve().parents[2]


def walk(value):
    if isinstance(value, Node):
        yield value
        for child in value.args:
            yield from walk(child)
    elif isinstance(value, (tuple, list)):
        for child in value:
            yield from walk(child)


def safe(value):
    return re.sub(r"\W", "_", value)


FIELDS = FIELD_ALIASES


class Emitter:
    def __init__(self, module, definition, all_definitions, artwork):
        self.module, self.definition = module, definition
        self.definitions, self.artwork = all_definitions, artwork
        self.locals = set(definition.parameters)
        for node in walk(definition.body):
            if node.kind == "var":
                self.locals.update(name for name, _ in node.args)
        self.async_mode = any(node.kind == "wait" or self.is_fork(node) for node in walk(definition.body))
        self.native_name = "fr_" + safe(module) + "_" + definition.name
        self.fork_entry = None
        self.native_scope = False
        self.temp = 0
        self.calls = set()
        self.sync_loop_stack = []
        self.draw_logic = False

    def domain(self, node):
        if node.kind == "identifier" and node.args[0] not in self.locals:
            name = node.args[0]
        elif node.kind == "member":
            if node.args[0].kind == "identifier" and node.args[0].args[0] == "global":
                return None
            name = node.args[1]
        else:
            return None
        if name in {"area", "lastarea", "hqarea", "spawnarea"}: return "Area"
        if name in {"wep", "bwep", "storedwep"}: return "Weapon"
        if name == "race": return "Race"
        return None

    @staticmethod
    def is_fork(node):
        return node.kind == "call" and node.args[0].kind == "identifier" and node.args[0].args[0] == "fork"

    def new(self, prefix):
        self.temp += 1
        return "__fr_" + prefix + str(self.temp)

    def with_targets(self, node):
        value = self.expression(node)
        return 'scrFRInstances(' + value + ')'

    def local(self, name):
        return "_fr.vars." + name if self.async_mode else "_frl_" + name

    def identifier(self, value):
        if value in self.locals:
            return self.local(value)
        if value == 'background_color':
            return 'scrFRBackgroundColour()'
        # NTT gives each loaded module its own global namespace. Sharing the
        # host's global struct silently cross-wires identically named sprites,
        # counters and options between independently loaded modules.
        if value == "global" and not self.module.startswith("tests/"):
            return "global.fr_module_vars[$ " + json.dumps(module_key(self.module)) + "]"
        if (not self.async_mode or self.native_scope) and value in {"self", "other"}:
            return "id" if value == "self" else "(scrFROther(other))"
        if value in self.definitions[self.module]:
            return "fr_" + safe(self.module) + "_" + value
        if value == "null":
            return "undefined"
        if value in API:
            return API[value]
        if not self.async_mode and re.fullmatch(r"argument\d+", value):
            index = int(value[8:])
            if index < len(self.definition.parameters):
                return self.local(self.definition.parameters[index])
        if self.async_mode:
            if value == "self":
                return "_fr.scope"
            if value == "other":
                return "_fr.other_scope"
            if value == "argument_count":
                return "array_length(_fr.args)"
            if re.fullmatch(r"argument\d+", value):
                return "_fr.args[" + value[8:] + "]"
            if value == "argument":
                return "_fr.args"
        if re.fullmatch(r"alarm\d+", value):
            return "alarm[" + value[5:] + "]"
        return FIELDS.get(value, value)

    def scale(self, node):
        if self.module.startswith("tests/compiler"):
            return None
        if node.kind=="identifier" and node.args[0] not in self.locals:
            return SCALED_FIELDS.get(node.args[0])
        if node.kind=="member":
            if node.args[0].kind=="identifier" and node.args[0].args[0]=="global":
                return None
            return SCALED_FIELDS.get(node.args[1])
        return None

    @staticmethod
    def factor(power):
        return "timescale" if power==1 else "(timescale * timescale)"

    def increment(self, target, delta, post):
        field=target.args[0] if target.kind=="identifier" else target.args[1]
        scope="id" if target.kind=="identifier" else self.expression(target.args[0])
        return "scrFRScaledIncrement("+scope+", "+json.dumps(FIELDS.get(field,field))+", "+str(delta)+", "+str(post).lower()+", "+self.factor(self.scale(target))+")"

    def maxhealth_scope(self, node):
        if node.kind == "identifier" and node.args[0] == "maxhealth" and "maxhealth" not in self.locals:
            return "id"
        if node.kind == "member" and node.args[1] == "maxhealth":
            if node.args[0].kind == "identifier" and node.args[0].args[0] in {"global", "GameCont"}:
                return None
            return self.expression(node.args[0])
        return None

    def domain_alternatives(self, node):
        if node.kind in {"string", "number"}:
            return [node]
        if node.kind == "binary" and node.args[0] in {"||", "or"}:
            left, right = self.domain_alternatives(node.args[1]), self.domain_alternatives(node.args[2])
            if left and right: return left+right
        return None

    def query_domain_value(self, domain, value):
        return "scrFR" + domain + "Resolve(" + value + ")"

    def expression(self, node, condition=False, lvalue=False):
        kind, args = node.kind, node.args
        if kind == "identifier":
            text=self.identifier(args[0])
            power=self.scale(node)
            return "("+text+" / "+self.factor(power)+")" if power and not lvalue else text
        if kind == "number":
            return args[0]
        if kind == "string":
            return json.dumps(args[0][1:-1], ensure_ascii=False)
        if kind == "template":
            return "(" + " + ".join(self.expression(child) if child.kind == "string" else "string(" + self.expression(child) + ")" for child in args) + ")"
        if kind == "array":
            return "[" + ", ".join(self.expression(child) for child in args) + "]"
        if kind == "member":
            target = self.expression(args[0])
            if args[0].kind not in {"identifier", "member", "index"}:
                target = "(" + target + ")"
            # Controller kill statistics and a module's global.kills counter
            # are not the per-enemy 'award kill credit' flag.
            preserve = args[0].kind == "identifier" and args[0].args[0] in {"global", "GameCont"}
            field=args[1]
            if not preserve and re.fullmatch(r"alarm\d+",field):
                text=target+".alarm["+field[5:]+"]"
            else:
                native_field = GAMECONT_FIELD_ALIASES.get(field,field) if preserve and args[0].args[0]=="GameCont" else field if preserve else FIELDS.get(field,field)
                text=target + "." + native_field
            power=self.scale(node)
            return "("+text+" / "+self.factor(power)+")" if power and not lvalue else text
        if kind == "index":
            if args[0].kind == "identifier":
                name=args[0].args[0]
                if name in {"view_xview","view_yview"}:
                    assert len(args[2])==1 and not args[1]
                    return name
                if name=="view_object":
                    assert len(args[2])==1 and not args[1]
                    return "global.fr_camera_targets["+self.expression(args[2][0])+"]"
            if args[0].kind == "identifier" and (ROOT / "project/objects" / args[0].args[0]).is_dir():
                assert len(args[2]) == 1 and not args[1], "Unsupported indexed object lookup"
                return "instance_find(" + args[0].args[0] + ", " + self.expression(args[2][0]) + ")"
            return self.expression(args[0]) + "[" + args[1] + ", ".join(self.expression(child) for child in args[2]) + "]"
        if kind == "unary":
            if args[0] in {"++","--"} and self.scale(args[1]):
                return self.increment(args[1],1 if args[0]=="++" else -1,False)
            return "(" + args[0] + " " + self.expression(args[1], condition) + ")"
        if kind == "postfix":
            if self.scale(args[0]):
                return self.increment(args[0],1 if args[1]=="++" else -1,True)
            return "(" + self.expression(args[0]) + args[1] + ")"
        if kind == "binary":
            op, left, right = args
            assignments={"=","+=","-=","*=","/=","%=","&=","|=","^=","<<=",">>="}
            if op in assignments and not condition:
                if left.kind == 'identifier' and left.args[0] == 'background_color':
                    assert op == '='
                    self.calls.add('background_set_colour')
                    return 'background_set_colour('+self.expression(right)+')'
                scope=self.maxhealth_scope(left)
                if scope is not None:
                    self.calls.add("scrFRMaxHealthWrite")
                    return "scrFRMaxHealthWrite("+scope+", "+self.expression(right)+", "+json.dumps(op)+")"
                power=self.scale(left)
                rhs=self.expression(right)
                if power and op in {"=","+=","-="}:
                    rhs="("+rhs+") * "+self.factor(power)
                elif power and op not in {"*=","/="}:
                    raise ValueError(f"Unsupported dimensional assignment {op} at {self.module}:{node.line}")
                domain = self.domain(left)
                if domain and op == "=":
                    rhs = "scrFR"+domain+"Resolve("+rhs+")"
                return "("+self.expression(left,lvalue=True)+" "+op+" "+rhs+")"
            if op in {"in", "not in"}:
                text = "scrFRVariableExists(" + self.expression(right) + ", " + self.expression(left) + ")"
                self.calls.add("scrFRVariableExists")
                return "(!" + text + ")" if op == "not in" else text
            op = "==" if condition and op == "=" else op
            a, b = self.expression(left, condition), self.expression(right, condition)
            if op in {"==", "!=", "<>", ">", "<", ">=", "<="}:
                # The supplied Harpoon Gun spells its two permitted areas as
                # area=("oasis"||101). Interpret this explicit value list as
                # alternatives, rather than converting a string to a bool.
                alternatives = self.domain_alternatives(right)
                if self.domain(left) and right.kind == "binary" and alternatives and op in {"==", "!=", "<>"}:
                    joiner = " || " if op == "==" else " && "
                    return "("+joiner.join("("+a+" "+op+" scrFR"+self.domain(left)+"Resolve("+self.expression(item)+"))" for item in alternatives)+")"
                if self.domain(left): b = "scrFR"+self.domain(left)+"Resolve("+b+")"
                elif self.domain(right): a = "scrFR"+self.domain(right)+"Resolve("+a+")"
            return "(" + a + " " + op + " " + b + ")"
        if kind == "ternary":
            return "(" + self.expression(args[0], True) + " ? " + self.expression(args[1]) + " : " + self.expression(args[2]) + ")"
        if kind == "call":
            callee, arguments = args
            if self.is_fork(node):
                if self.fork_entry is None:
                    raise ValueError(f"Unlowered fork at {self.module}:{node.line}")
                return f"scrFRTaskFork(_fr, {self.fork_entry})"
            name = callee.args[0] if callee.kind == "identifier" else None
            if name in {"script_ref_create", "script_bind_draw", "script_bind_end_step"} and arguments:
                first = arguments[0]
                if first.kind == "string":
                    local_name = first.args[0][1:-1]
                    assert local_name in self.definitions[self.module], (self.module, node.line, local_name)
                    arguments = [Node("identifier", [local_name], first.line), *arguments[1:]]
            if name and name.startswith("sprite_") and "base64" in name:
                asset = self.artwork[(self.module, node.line)]
                resource = asset["native_resource"]
                if name.startswith("sprite_replace"):
                    self.calls.add("scrFRSpriteReplace")
                    return "scrFRSpriteReplace(" + self.expression(arguments[0]) + ", " + resource + ")"
                return resource
            text = self.expression(callee)
            if name:
                self.calls.add(name)
            values=[self.expression(child) for child in arguments]
            if name == "either" and arguments and self.domain(arguments[0]):
                domain=self.domain(arguments[0])
                values=values[:1]+[self.query_domain_value(domain,value) for value in values[1:]]
            return text + "(" + ", ".join(values) + ")"
        raise NotImplementedError((kind, node.line))

    def simple(self, node):
        kind, args = node.kind, node.args
        if kind == "empty":
            return ";"
        if kind == "expr":
            # Modern GML does not accept parenthesized assignment statements.
            text = self.expression(args[0])
            if args[0].kind in {"binary", "postfix", "unary"} and text.startswith("(") and text.endswith(")"):
                text = text[1:-1]
            if "(scrFROther(other))" in text:
                # GMS2 statement lvalues cannot start with a parenthesized
                # function result. Resolve NTT's logical other in this exact
                # with scope, including callbacks entered from a coroutine.
                other = self.new("other")
                text = "var " + other + "=scrFROther(other);\n" + text.replace("(scrFROther(other))", other)
            text += ";"
            expression=args[0]
            target=None
            if expression.kind=='binary' and expression.args[0] in {'=','+=','-=','*=','/='}:
                target=expression.args[1]
            elif expression.kind=='postfix':target=expression.args[0]
            elif expression.kind=='unary' and expression.args[0] in {'++','--'}:target=expression.args[1]
            if self.draw_logic and target and (target.kind!='identifier' or target.args[0] not in self.locals):
                text='if(scrFRReadyTick()) { '+text+' }'
            return text
        if kind == "var":
            return "\n".join(("" if self.async_mode else "var ") + self.local(name) + (" = " + self.expression(init) if init else " = undefined") + ";"
                             for name, init in args)
        if kind == "macro":
            return "#macro " + args[0] + " " + self.expression(args[1])
        if kind == "return":
            return "return" + (" " + self.expression(args[0]) if args else "") + ";"
        if kind in {"break", "continue", "exit"}:
            if kind == "break" and self.sync_loop_stack and self.sync_loop_stack[-1] is not None:
                return self.sync_loop_stack[-1] + "=true; break;"
            return kind + ";"
        raise NotImplementedError((kind, node.line))

    def sync(self, node):
        kind, args = node.kind, node.args
        if kind == "block":
            return "{\n" + "\n".join(self.sync(child) for child in args) + "\n}"
        if kind == "if":
            condition=self.expression(args[0], True)
            if self.draw_logic and any(n.kind=='call' and n.args[0].kind=='identifier' and n.args[0].args[0]=='random' for n in walk(args[0])):
                condition='scrFRReadyTick() && ('+condition+')'
            text = "if (" + condition + ") {\n" + self.sync(args[1]) + "\n}"
            if args[2].kind != "empty":
                text += " else {\n" + self.sync(args[2]) + "\n}"
            return text
        if kind in {"while", "repeat"}:
            self.sync_loop_stack.append(None)
            body = self.sync(args[1])
            self.sync_loop_stack.pop()
            return kind + " (" + self.expression(args[0], kind == "while") + ") " + body
        if kind in {"do", "do_while"}:
            self.sync_loop_stack.append(None)
            body = self.sync(args[0])
            self.sync_loop_stack.pop()
            return "do " + body + (" until (" if kind == "do" else " until (!(") + self.expression(args[1], True) + (");" if kind=="do" else "));" )
        if kind == "for":
            # A legacy for initializer may declare several locals. Each
            # declaration is emitted as its own statement, outside the header;
            # this also handles a parameter redeclared with var safely.
            init = self.sync(args[0])
            step = self.simple(Node("expr", [args[2]], node.line)).rstrip(";") if args[2] else ""
            self.sync_loop_stack.append(None)
            body = self.sync(args[3])
            self.sync_loop_stack.pop()
            return "{\n" + init + "\nfor (; " + self.expression(args[1], True) + "; " + step + ") " + body + "\n}"
        if kind == "with":
            items, index, flag = self.new("with"), self.new("index"), self.new("break")
            self.sync_loop_stack.append(flag)
            body = self.sync(args[1])
            self.sync_loop_stack.pop()
            return "{ var " + items + " = " + self.with_targets(args[0]) + ", " + flag + "=false;\nfor (var " + index + "=0; " + index + "<array_length(" + items + "); ++" + index + ") {\nif(instance_exists(" + items + "[" + index + "])) with (" + items + "[" + index + "]) {\n" + body + "\n}\nif(" + flag + ") break;\n}}"
        if kind == "switch":
            self.sync_loop_stack.append(None)
            text = "switch (" + self.expression(args[0]) + ") {\n"
            for label, body in args[1]:
                value=self.expression(label) if label else ""
                domain=self.domain(args[0])
                if domain and label: value=self.query_domain_value(domain,value)
                text += ("case " + value if label else "default") + ":\n" + "\n".join(self.sync(child) for child in body.args) + "\n"
            self.sync_loop_stack.pop()
            return text + "}"
        return self.simple(node)

    def emit(self):
        if not self.async_mode:
            params = ", ".join(self.local(name)+"=undefined" for name in self.definition.parameters)
            return "function " + self.native_name + "(" + params + ") " + self.sync(self.definition.body)
        flow = getattr(self, "flow_class", Flow)(self)
        entry = flow.compile(self.definition.body, 0)
        code = self.native_name + "_resume"
        text = "function " + self.native_name + "() {\nvar _args = [];\nfor(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);\n"
        parameters = json.dumps(self.definition.parameters)
        text += f"return scrFRTaskStart({code}, id, scrFROther(other), _args, {entry}, {parameters});\n}}\n"
        text += f"function {code}(_fr) {{\nvar _budget=0;\nwhile(!_fr.done) {{\nassert(++_budget<100000,\"Frontier runaway continuation: {self.native_name}\");\n"
        text += "if (!instance_exists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }\n"
        text += "with (_fr.scope) { switch (_fr.pc) {\ncase 0: _fr.done=true; return;\n"
        for pc, (line, body) in flow.blocks.items():
            text += f"case {pc}: // {self.module}:{line}\n{body}\nbreak;\n"
        text += "default: throw \"Frontier invalid continuation PC\";\n}}\n}\n}\n"
        return text


class Flow:
    def __init__(self, emitter):
        self.e = emitter
        self.blocks = {}
        self.next_pc = 1

    def reserve(self):
        pc = self.next_pc
        self.next_pc += 1
        return pc

    def set(self, pc, line, text):
        self.blocks[pc] = (line, text)
        return pc

    def add(self, line, text):
        return self.set(self.reserve(), line, text)

    def synchronous(self, node, breaks=0, continues=0):
        if not isinstance(node, Node): return True
        if node.kind in {"wait","return","exit"} or self.e.is_fork(node): return False
        if node.kind=="break" and breaks==0: return False
        if node.kind=="continue" and continues==0: return False
        loop=node.kind in {"with","while","do","do_while","repeat","for"}
        next_breaks=breaks+loop+(node.kind=="switch")
        next_continues=continues+loop
        def safe_child(child):
            if isinstance(child,Node): return self.synchronous(child,next_breaks,next_continues)
            if isinstance(child,(list,tuple)): return all(safe_child(c) for c in child)
            return True
        return all(safe_child(child) for child in node.args)

    def compile(self, node, after, break_to=None, continue_to=None):
        kind, args, line = node.kind, node.args, node.line
        if kind not in {"empty","expr","var","macro"} and self.synchronous(node):
            self.e.native_scope=True
            try: text=self.e.sync(node)
            finally: self.e.native_scope=False
            return self.add(line,text+f"\n_fr.pc={after};")
        if kind == "empty":
            return after
        if kind == "block":
            # Contiguous code without a suspension executes atomically as in
            # NTT. In particular, a wall may destroy itself and create its
            # replacement before leaving the current event scope.
            groups=[]
            pending=[]
            for child in args:
                if self.synchronous(child):
                    pending.append(child)
                else:
                    if pending:
                        groups.append(Node('block',pending,pending[0].line));pending=[]
                    groups.append(child)
            if pending: groups.append(Node('block',pending,pending[0].line))
            for child in reversed(groups):
                after = self.compile(child, after, break_to, continue_to)
            return after
        if kind == "if":
            yes = self.compile(args[1], after, break_to, continue_to)
            no = self.compile(args[2], after, break_to, continue_to)
            previous = self.e.fork_entry
            self.e.fork_entry = yes
            expression = self.e.expression(args[0], True)
            self.e.fork_entry = previous
            return self.add(line, f"_fr.pc = ({expression}) ? {yes} : {no};")
        if kind == "wait":
            duration = self.e.expression(args[0]) if args else "1"
            return self.add(line, f"_fr.wait_ticks=max(0,{duration}); _fr.pc={after}; return;")
        if kind in {"return", "exit"}:
            result = self.e.expression(args[0]) if args else "undefined"
            return self.add(line, f"_fr.result={result}; _fr.done=true; return;")
        if kind in {"break", "continue"}:
            dest = break_to if kind == "break" else continue_to
            if dest is None:
                raise ValueError(f"Unbound {kind} at {self.e.module}:{line}")
            return self.add(line, f"_fr.pc={dest};")
        if kind == "with":
            done = self.add(line, "scrFRTaskWithNext(_fr);")
            abort = self.add(line, "scrFRTaskWithAbort(_fr);")
            body = self.compile(args[1], done, abort, done)
            targets = self.e.with_targets(args[0])
            return self.add(line, f"scrFRTaskWithEnter(_fr,{targets},{body},{after});")
        if kind in {"while", "do", "do_while", "repeat", "for"}:
            check = self.reserve()
            if kind == "repeat":
                key = self.e.new("repeat")
                decrement = self.add(line, f"_fr.vars.{key}--; _fr.pc={check};")
                body = self.compile(args[1], decrement, after, decrement)
                self.set(check, line, f"_fr.pc=(_fr.vars.{key}>0)?{body}:{after};")
                return self.add(line, f"_fr.vars.{key}=round({self.e.expression(args[0])}); _fr.pc={check};")
            if kind == "for":
                increment = self.add(line, (self.e.simple(Node("expr", [args[2]], line)) if args[2] else "") + f" _fr.pc={check};")
                body = self.compile(args[3], increment, after, increment)
                self.set(check, line, f"_fr.pc=({self.e.expression(args[1],True)})?{body}:{after};")
                return self.compile(args[0], check, break_to, continue_to)
            if kind == "while":
                body = self.compile(args[1], check, after, check)
                self.set(check, line, f"_fr.pc=({self.e.expression(args[0],True)})?{body}:{after};")
                return check
            body = self.compile(args[0], check, after, check)
            yes, no = (after, body) if kind == "do" else (body, after)
            self.set(check, line, f"_fr.pc=({self.e.expression(args[1],True)})?{yes}:{no};")
            return body
        if kind == "switch":
            key = self.e.new("switch")
            case_entries = []
            next_case = after
            for label, body in reversed(args[1]):
                next_case = self.compile(body, next_case, after, continue_to)
                case_entries.insert(0, (label, next_case))
            default = next((entry for label, entry in case_entries if label is None), after)
            text = f"_fr.vars.{key}={self.e.expression(args[0])};\n"
            for label, entry in case_entries:
                if label:
                    value=self.e.expression(label)
                    domain=self.e.domain(args[0])
                    if domain: value=self.e.query_domain_value(domain,value)
                    text += f"if (_fr.vars.{key}=={value}) {{_fr.pc={entry};}} else "
            text += f"{{_fr.pc={default};}}"
            return self.add(line, text)
        return self.add(line, self.e.simple(node) + f"\n_fr.pc={after};")

