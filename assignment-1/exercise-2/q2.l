%{
#include <stdio.h>
%}

%%

[0-9]+                         { printf("NUMBER %s\n", yytext); }
"<="|">="|"=="|"!="|"<"|">"    { printf("REL_OP %s\n", yytext); }
"+"                            { printf("PLUS\n"); }
"-"                            { printf("MINUS\n"); }
"*"                            { printf("TIMES\n"); }
"/"                            { printf("DIVIDE\n"); }
"|"                            { printf("ABS\n"); }
"("                            { printf("LPAREN\n"); }
")"                            { printf("RPAREN\n"); }
"%"                            { printf("MOD\n"); }
"^"                            { printf("POWER\n"); }
\n                             { printf("NEWLINE\n"); }
[ \t]+                         {  }
.                              { printf("Mystery character %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}
