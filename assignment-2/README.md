# Assignment 2 — Lexical analyzers and start conditions

This assignment builds complete lexical analyzers that report each token, its
lexeme, and source line. The original specification is available in
[assignment-2.pdf](assignment-2.pdf).

## Exercises

1. A lexer for a selected subset of C++.
2. A lexer for MiniLang, including reserved words, malformed lexemes,
   single-line comments, and multiline comments handled with a start condition.

The MiniLang solution also includes the five programs supplied in the
assignment, their outputs, and five additional test cases.

## Build and run

Run the following commands inside either exercise directory:

```bash
flex lexer.l
gcc lex.yy.c -o scanner
./scanner path/to/input.txt
```
