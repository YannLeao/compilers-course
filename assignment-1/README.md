# Assignment 1 — lexical analyzers with Flex

This assignment introduces complete Flex specifications composed of the
definitions, rules, and user code sections. The original assignment is
available in [assignment-1.pdf](assignment-1.pdf).

## Exercises

1. Text statistics counter for lines, words, characters, integers,
   floating-point numbers, and punctuation marks.
2. Lexical analyzer for a calculator, including arithmetic and relational
   operators and parentheses.
3. Lexical analyzer for a small programming language with reserved words,
   identifiers, numbers, and line comments.
4. Adaptation of exercise 3 that reads from a file provided as a command-line
   argument and handles input errors.

Each exercise has its own directory containing the `.l` specification, a test
input, and its corresponding output:

```text
assignment-1/
├── exercise-1/
│   ├── q1.l
│   ├── input.txt
│   └── output.txt
├── exercise-2/
│   └── ...
├── exercise-3/
│   └── ...
└── exercise-4/
    └── ...
```

## Build and run

Replace `N` with the exercise number:

```bash
flex assignment-1/exercise-N/qN.l
gcc lex.yy.c -o scanner
./scanner < assignment-1/exercise-N/input.txt
```

To compare the program output with the expected result without creating
additional files:

```bash
./scanner < assignment-1/exercise-N/input.txt \
  | diff -u assignment-1/exercise-N/output.txt -
```

For exercise 4, pass the input path as an argument instead of redirecting
standard input:

```bash
./scanner assignment-1/exercise-4/input.txt
```

## Submission checklist

- [x] Every exercise contains a complete `.l` file.
- [x] Every exercise contains test input and output files.
- [x] Every program builds from a clean copy of the repository.
- [x] `lex.yy.c`, generated files, and executables are not tracked.
- [ ] The repository is public and accessible from an anonymous browser window.
- [ ] The correct link has been submitted through Classroom.
