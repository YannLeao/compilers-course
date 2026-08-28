%option noyywrap noinput nounput nodefault

%{
#include "calculator.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
"printar_variaveis"         { return PRINT; }
[0-9]+(\.[0-9]+)?           { yylval.val = atof(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*      {
                                size_t length = (size_t)yyleng;
                                char *copy = malloc(length + 1);
                                memcpy(copy, yytext, length);
                                copy[length] = '\0';
                                yylval.string = copy;
                                return ID;
                            }
">>>"                       { return ASSIGN; }
"**"                        { return POT; }
"+"                         { return MAIS; }
"-"                         { return MENOS; }
"*"                         { return VEZES; }
"/"                         { return DIVISAO; }
"("                         { return ABRE_PAREN; }
")"                         { return FECHA_PAREN; }
[ \t]+                      { }
\n                          { return '\n'; }
.                           { return yytext[0]; }
%%
