# Activity 3 — Flex and Bison integration

This activity introduces semantic values, grammar rules, precedence, and the
communication between a Flex scanner and a Bison parser. The original
specification is available in [activity-3.pdf](activity-3.pdf).

## Questions

1. A calculator with expressions, assignment, persistent variables, unary
   minus, and right-associative exponentiation.
2. A parser for C-style declarations that builds a symbol table and reports
   duplicate names.

## Build and run

Each question provides its own Makefile. From a question directory:

```bash
make
./calculator input.txt   # question 1
./declaration input.txt  # question 2
make clean
```
