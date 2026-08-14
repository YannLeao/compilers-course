# Compilers

Repository for practical assignments from the Compilers course. The exercises
explore the construction of lexical analyzers with Flex and, in future
assignments, parsers with Bison.

The directories use descriptive English names, as agreed with the professor:

```text
activity-N/
├── README.md
├── activity-N.pdf
└── question-N/
    ├── qN.l or qN.y
    ├── input.txt
    └── output.txt
```

## Requirements

- Flex
- Bison (for future assignments)
- A GCC-compatible C compiler

On Debian- or Ubuntu-based distributions, the tools can be installed with:

```bash
sudo apt install flex bison build-essential
```

## Usage

To compile a Flex specification from the repository root:

```bash
flex activity-1/question-1/q1.l
gcc lex.yy.c -o scanner
./scanner
```

Input ends at EOF (`Ctrl+D` on Linux and macOS). A test file can also be
redirected to the program:

```bash
./scanner < activity-1/question-1/input.txt
```

The exact command may change when a question requires additional options or
the combined use of Flex and Bison. Such differences will be documented in the
corresponding assignment README.

## Assignments

- [Assignment 1 — lexical analyzers with Flex](activity-1/README.md)
