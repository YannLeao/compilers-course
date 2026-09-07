# Assignment 3 — Flex and Bison integration

This assignment introduces semantic values, grammar rules, precedence, and the
communication between a Flex scanner and a Bison parser. The original
specification is available in [assignment-3.pdf](assignment-3.pdf).

## Exercises

1. A calculator with expressions, assignment, persistent variables, unary
   minus, and right-associative exponentiation.
2. A parser for C-style declarations that builds a symbol table and reports
   duplicate names.

## Build and run

Each exercise provides its own Makefile. From an exercise directory:

```bash
make
./calc input.txt  # exercise 1
./decl input.txt  # exercise 2
make clean
```
