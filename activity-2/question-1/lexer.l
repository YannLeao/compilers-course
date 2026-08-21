%option noyywrap yylineno nodefault noinput nounput

%{
#include <stdio.h>

static int comment_start_line;
#define TOKEN(type) printf("LINHA %d: " type "(%s)\n", yylineno, yytext)
#define ERROR(msg)  printf("LINHA %d: ERRO_LEXICO(%s): %s\n", \
                           yylineno, yytext, msg)
%}

%x COMMENT

ID          [a-zA-Z_][a-zA-Z0-9_]*
INTEGER     [0-9]+
REAL        (([0-9]+\.[0-9]*)|(\.[0-9]+))([eE][+-]?[0-9]+)?
STRING      \"([^\"\\\n]|\\.)*\"
CHARACTER   \'([^\'\\\n]|\\.)\'

%%

"if"                         { TOKEN("KEYWORD"); }
"else"                       { TOKEN("KEYWORD"); }
"while"                      { TOKEN("KEYWORD"); }
"return"                     { TOKEN("KEYWORD"); }
"switch"                     { TOKEN("KEYWORD"); }
"case"                       { TOKEN("KEYWORD"); }
"default"                    { TOKEN("KEYWORD"); }
"do"                         { TOKEN("KEYWORD"); }
"for"                        { TOKEN("KEYWORD"); }
"break"                      { TOKEN("KEYWORD"); }
"continue"                   { TOKEN("KEYWORD"); }
"goto"                       { TOKEN("KEYWORD"); }
"int"                        { TOKEN("KEYWORD"); }
"float"                      { TOKEN("KEYWORD"); }
"char"                       { TOKEN("KEYWORD"); }
"long"                       { TOKEN("KEYWORD"); }
"double"                     { TOKEN("KEYWORD"); }
"bool"                       { TOKEN("KEYWORD"); }
"void"                       { TOKEN("KEYWORD"); }
"short"                      { TOKEN("KEYWORD"); }
"signed"                     { TOKEN("KEYWORD"); }
"unsigned"                   { TOKEN("KEYWORD"); }
"auto"                       { TOKEN("KEYWORD"); }

"//"[^\n]*                  { /* Ignore single-line comments. */ }
"/*"                        { comment_start_line = yylineno; BEGIN(COMMENT); }
<COMMENT>"*/"               { BEGIN(INITIAL); }
<COMMENT>\n                 { /* yylineno is updated automatically. */ }
<COMMENT>.                  { /* Ignore comment contents. */ }
<COMMENT><<EOF>>            {
                               printf("LINHA %d: ERRO_LEXICO: comentario sem fechamento\n",
                                      comment_start_line);
                               BEGIN(INITIAL);
                               return 0;
                           }

"<="                         { TOKEN("LESS_EQUAL"); }
">="                         { TOKEN("GREATER_EQUAL"); }
"=="                         { TOKEN("EQUAL"); }
"!="                         { TOKEN("NOT_EQUAL"); }
"<"                          { TOKEN("LESS"); }
">"                          { TOKEN("GREATER"); }
"&&"                         { TOKEN("AND"); }
"||"                         { TOKEN("OR"); }
"!"                          { TOKEN("NOT"); }
"++"                         { TOKEN("INCREMENT"); }
"--"                         { TOKEN("DECREMENT"); }
"+"                          { TOKEN("PLUS"); }
"-"                          { TOKEN("MINUS"); }
"*"                          { TOKEN("TIMES"); }
"/"                          { TOKEN("DIVIDE"); }
"%"                          { TOKEN("MODULO"); }
"="                         { TOKEN("ASSIGN"); }
"&"                          { TOKEN("BITWISE_AND"); }
"|"                          { TOKEN("BITWISE_OR"); }
"^"                          { TOKEN("BITWISE_XOR"); }
"~"                          { TOKEN("BITWISE_NOT"); }
"("                          { TOKEN("LPAREN"); }
"["                          { TOKEN("LBRACKET"); }
"{"                          { TOKEN("LBRACE"); }
")"                          { TOKEN("RPAREN"); }
"]"                          { TOKEN("RBRACKET"); }
"}"                          { TOKEN("RBRACE"); }
";"                          { TOKEN("SEMICOLON"); }
","                          { TOKEN("COMMA"); }
":"                          { TOKEN("COLON"); }

{STRING}                    { TOKEN("STRING"); }
{CHARACTER}                 { TOKEN("CHARACTER"); }
\"([^\"\\\n]|\\.)*         { ERROR("string sem fechamento"); }
\'([^\'\\\n]|\\.)*          { ERROR("literal de caractere sem fechamento"); }
{REAL}                      { TOKEN("REAL"); }
{INTEGER}                   { TOKEN("INTEGER"); }
{ID}                        { TOKEN("IDENTIFIER"); }
[ \t\r\n]+                 { /* Ignore whitespace. */ }
.                           { ERROR("simbolo nao reconhecido"); }

%%

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
