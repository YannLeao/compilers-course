# Assignment 5 — JSON validator with Flex and Bison

This assignment implements a syntax-only validator for a simplified JSON
grammar. Flex recognizes strings, numbers, literals, and punctuation, while
Bison checks objects, arrays, nesting, separators, and the single top-level
value rule.

## Build and run

```bash
make
./valida path/to/file.json
make clean
```

The program prints exactly `JSON OK` for valid input or `JSON COM ERRO` for
invalid input.
