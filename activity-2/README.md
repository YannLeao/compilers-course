# Activity 2 — lexical analyzers and start conditions

This activity builds complete lexical analyzers that report each token, its
lexeme, and source line. The original specification is available in
[activity-2.pdf](activity-2.pdf).

## Questions

1. A lexer for a selected subset of C++.
2. A lexer for MiniLang, including reserved words, malformed lexemes,
   single-line comments, and multiline comments handled with a start condition.

The MiniLang solution also includes the five programs supplied in the
assignment, their outputs, and five additional test cases.

## Build and run

Run the following commands inside either question directory:

```bash
flex lexer.l
gcc lex.yy.c -o scanner
./scanner path/to/input.txt
```
