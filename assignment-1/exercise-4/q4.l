%{
#include <stdio.h>
%}

%%

if                         { printf("IF\n"); }
else                       { printf("ELSE\n"); }
while                      { printf("WHILE\n"); }
return                     { printf("RETURN\n"); }
[a-zA-Z_][a-zA-Z0-9_]*     { printf("ID %s\n", yytext); }
[0-9]+(\.[0-9]+)?          { printf("NUMBER %s\n", yytext); }
"//"[^\n]*                 {  }
[ \t\n]                    {  }
.                          { printf("SYMBOL %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("No file was passed.\n");
        return 1;
    }

    FILE *input = fopen(argv[1], "r");

    if (input == NULL) {
        printf("The argument is not a valid file or could not be opened.\n");
        return 1;
    }

    yyin = input;
    yylex();

    fclose(input);
    return 0;
}
