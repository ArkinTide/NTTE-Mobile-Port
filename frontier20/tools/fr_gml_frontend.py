"""Read the legacy NTT source with positions retained for native-port audits."""
from dataclasses import dataclass
import re


@dataclass(frozen=True)
class Token:
    kind: str
    text: str
    start: int
    end: int
    line: int


PATTERN = re.compile(
    r'(?P<space>\s+)|(?P<comment>//[^\n]*|/\*[\s\S]*?(?:\*/|$))'
    # NTT's legacy GML strings do not treat a backslash before a quote as an
    # escape. For example "\\" is a one-character string in the supplied MOD.
    # Preserve literal contents and escape only when emitting modern GML.
    r'|(?P<string>"[^"]*"|\'[^\']*\'|`[^`]*`)'
    r'|(?P<number>0[xX][\da-fA-F]+|\$[\da-fA-F]+|(?:\d+\.\d*|\.\d+|\d+)(?:[eE][+-]?\d+)?)'
    r'|(?P<identifier>[A-Za-z_][A-Za-z_\d]*)'
    r'|(?P<operator><<=|>>=|==|!=|<>|<=|>=|\+\+|--|\+=|-=|\*=|/=|\\=|%=|&&|\|\||\^\^|<<|>>|\?\?|[{}()[\].,;?:#+*/%<>=!&|^~@\\$-])',
    re.DOTALL,
)


def tokenize(text):
    result, position, line = [], 0, 1
    while position < len(text):
        match = PATTERN.match(text, position)
        if not match:
            raise SyntaxError(f"Unrecognized source character at line {line}: {text[position:position+40]!r}")
        value = match.group()
        if match.lastgroup not in {"space", "comment"}:
            result.append(Token(match.lastgroup, value, position, match.end(), line))
        line += value.count("\n")
        position = match.end()
    return result


def call_arguments(tokens, index):
    """Return original token ranges, including nested expressions, without eval."""
    assert tokens[index + 1].text == "("
    depth, start, arguments = 1, index + 2, []
    for cursor in range(start, len(tokens)):
        value = tokens[cursor].text
        if value in {"(", "[", "{"}:
            depth += 1
        elif value in {")", "]", "}"}:
            depth -= 1
            if depth == 0:
                if cursor > start:
                    arguments.append(tokens[start:cursor])
                return arguments, cursor
        if value == "," and depth == 1:
            arguments.append(tokens[start:cursor])
            start = cursor + 1
    raise SyntaxError(f"Unclosed call at line {tokens[index].line}")


def original_text(text, tokens):
    return text[tokens[0].start:tokens[-1].end] if tokens else ""
