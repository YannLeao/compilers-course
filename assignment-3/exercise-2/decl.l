%option noyywrap noinput nounput nodefault

%{
#include "decl.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
"int"                       { yylval.type = "int"; return TYPE; }
"char"                      { yylval.type = "char"; return TYPE; }
"double"                    { yylval.type = "double"; return TYPE; }

","                         { return COMMA; }
";"                         { return SEMICOLON; }

[a-zA-Z_][a-zA-Z0-9_]*      {
                                size_t length = (size_t)yyleng;
                                char *copy = malloc(length + 1);
                                memcpy(copy, yytext, length);
                                copy[yyleng] = '\0';
                                yylval.identifier = copy;
                                return ID;
                            }
[ \t\n]+                    { }
.                           { return yytext[0]; }
%%
