# Assignment 1 — lexical analyzers with Flex

This assignment introduces complete Flex specifications composed of the
definitions, rules, and user code sections. The original assignment is
available in [activity-1.pdf](activity-1.pdf).

## Questions

1. Text statistics counter for lines, words, characters, integers,
   floating-point numbers, and punctuation marks.
2. Lexical analyzer for a calculator, including arithmetic and relational
   operators and parentheses.
3. Lexical analyzer for a small programming language with reserved words,
   identifiers, numbers, and line comments.
4. Adaptation of question 3 that reads from a file provided as a command-line
   argument and handles input errors.

Each question has its own directory containing the `.l` specification, a test
input, and its corresponding output:

```text
activity-1/
├── question-1/
│   ├── q1.l
│   ├── input.txt
│   └── output.txt
├── question-2/
│   └── ...
├── question-3/
│   └── ...
└── question-4/
    └── ...
```

## Build and run

Replace `N` with the question number:

```bash
flex activity-1/question-N/qN.l
gcc lex.yy.c -o scanner
./scanner < activity-1/question-N/input.txt
```

To compare the program output with the expected result without creating
additional files:

```bash
./scanner < activity-1/question-N/input.txt \
  | diff -u activity-1/question-N/output.txt -
```

For question 4, pass the input path as an argument instead of redirecting
standard input:

```bash
./scanner activity-1/question-4/input.txt
```

## Submission checklist

- [x] Every question contains a complete `.l` file.
- [x] Every question contains test input and output files.
- [x] Every program builds from a clean copy of the repository.
- [x] `lex.yy.c`, generated files, and executables are not tracked.
- [ ] The repository is public and accessible from an anonymous browser window.
- [ ] The correct link has been submitted through Classroom.
