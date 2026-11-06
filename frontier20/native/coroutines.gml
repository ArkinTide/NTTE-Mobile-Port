// Native resumable continuations for the legacy NTT wait/fork statements.
// Every task owns its locals and with-stack; there is no source eval at runtime.
function scrFRTaskRuntimeInit() {
    global.fr_tasks = [];
    global.fr_task_tick = 0;
    global.fr_final_callback_scope = undefined;
}

function scrFRTaskCopyStruct(_source) {
    var _copy = {}, _keys = variable_struct_get_names(_source);
    for (var _i=0; _i<array_length(_keys); ++_i) {
        variable_struct_set(_copy, _keys[_i], variable_struct_get(_source, _keys[_i]));
    }
    return _copy;
}

function scrFRTaskMake(_code, _scope, _other, _args, _entry) {
    var _final=global.fr_final_callback_scope;
    if(!is_struct(_final) || is_struct(_scope) || is_undefined(_scope)
       || real(_scope)!=_final.source) _final=undefined;
    if(is_struct(_final)) _final.used=true;
    return {code:_code, scope:_scope, other_scope:_other, args:_args, pc:_entry,
        vars:{}, with_stack:[], with_floor:0, wait_ticks:0, done:false, result:undefined,
        last_tick:global.fr_task_tick, final_scope:_final};
}

function scrFRTaskRestoreScope(_task,_scope) {
    var _final=_task.final_scope;
    if(is_struct(_final) && !is_struct(_scope) && _scope==_final.source
       && !instance_exists(_scope) && is_struct(_final.snapshot)) return _final.snapshot;
    return _scope;
}

function scrFRTaskRun(_task) {
    if (_task.done) return;
    _task.last_tick = global.fr_task_tick;
    _task.scope=scrFRTaskRestoreScope(_task,_task.scope);
    _task.other_scope=scrFRTaskRestoreScope(_task,_task.other_scope);
    // The generated function enters the recorded instance scope for each
    // basic block, so nested with and locals survive a suspension.
    _task.code(_task);
}

function scrFRTaskStart(_code, _scope, _other, _args, _entry, _params=[]) {
    var _task = scrFRTaskMake(_code, _scope, _other, _args, _entry);
    for (var _i=0; _i<array_length(_params); ++_i) {
        variable_struct_set(_task.vars, _params[_i], _i<array_length(_args)?_args[_i]:undefined);
    }
    scrFRTaskRun(_task);
    if (!_task.done) array_push(global.fr_tasks, _task);
    return _task.result;
}

function scrFRTaskFork(_parent, _entry) {
    var _child = scrFRTaskMake(_parent.code, _parent.scope, _parent.other_scope, _parent.args, _entry);
    _child.vars = scrFRTaskCopyStruct(_parent.vars);
    _child.final_scope=_parent.final_scope;
    for (var _i=0; _i<array_length(_parent.with_stack); ++_i) {
        array_push(_child.with_stack, scrFRTaskCopyStruct(_parent.with_stack[_i]));
    }
    _child.with_floor=array_length(_parent.with_stack);
    scrFRTaskRun(_child);
    if (!_child.done) array_push(global.fr_tasks, _child);
    // In NTT's idiom the child executes the true arm; the original caller
    // continues with the false arm and must not wait for the child.
    return false;
}

function scrFRTaskWithEnter(_task, _targets, _body, _after) {
    var _frame = {scope:_task.scope, other_scope:_task.other_scope, targets:_targets,
                  index:-1, body:_body, after:_after};
    array_push(_task.with_stack, _frame);
    scrFRTaskWithNext(_task);
}

function scrFRTaskWithNext(_task) {
    var _stack = _task.with_stack, _last = array_length(_stack)-1;
    assert(_last>=0, "Frontier coroutine with-stack underflow");
    var _frame = _stack[_last];
    while (++_frame.index < array_length(_frame.targets)) {
        var _target = _frame.targets[_frame.index];
        if (!scrFRScopeExists(_target)) continue;
        _task.scope = _target;
        _task.other_scope = _frame.scope;
        _task.pc = _frame.body;
        return;
    }
    _task.scope = scrFRTaskRestoreScope(_task,_frame.scope);
    _task.other_scope = scrFRTaskRestoreScope(_task,_frame.other_scope);
    _task.pc = _frame.after;
    array_pop(_task.with_stack);
}

function scrFRTaskWithAbort(_task) {
    var _frame = array_pop(_task.with_stack);
    _task.scope = scrFRTaskRestoreScope(_task,_frame.scope);
    _task.other_scope = scrFRTaskRestoreScope(_task,_frame.other_scope);
    _task.pc = _frame.after;
}

function scrFRTasksTick(_delta) {
    global.fr_task_tick++;
    var _count = array_length(global.fr_tasks);
    for (var _i=0; _i<_count; ++_i) {
        var _task = global.fr_tasks[_i];
        if (_task.done || _task.last_tick==global.fr_task_tick) continue;
        if(!is_struct(_task.scope) && instance_exists(_task.scope) && (_task.scope[$ "frozen"]??false)) continue;
        _task.wait_ticks -= _delta;
        if (_task.wait_ticks<=0) scrFRTaskRun(_task);
    }
    // Compact once. Repeated array_delete shifts the remaining task queue
    // quadratically during large boss/terrain effect bursts. Include forks
    // appended during this tick without resuming them a second time.
    var _live=[];
    for(var _i=0;_i<array_length(global.fr_tasks);++_i)
        if(!global.fr_tasks[_i].done) array_push(_live,global.fr_tasks[_i]);
    global.fr_tasks=_live;
}

