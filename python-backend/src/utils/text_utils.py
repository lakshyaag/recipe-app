from cleantext import clean


def sanitize_text(text: str) -> str:
    return clean(
        text,
        fix_unicode=True,
        to_ascii=True,
        lower=True,
        normalize_whitespace=True,
        no_line_breaks=True,
        strip_lines=True,
    )
