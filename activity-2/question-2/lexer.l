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
REAL        [0-9]+,[0-9]+
STRING      "’"[^’\n]*"’"

%%

"inicio"                     { TOKEN("KEYWORD"); }
"fim"                        { TOKEN("KEYWORD"); }
"inteiro"                    { TOKEN("KEYWORD"); }
"real"                       { TOKEN("KEYWORD"); }
"texto"                      { TOKEN("KEYWORD"); }
"booleano"                   { TOKEN("KEYWORD"); }
"se"                         { TOKEN("KEYWORD"); }
"faz"                        { TOKEN("KEYWORD"); }
"senao"                      { TOKEN("KEYWORD"); }
"repita_enquanto"            { TOKEN("KEYWORD"); }
"para"                       { TOKEN("KEYWORD"); }
"de"                         { TOKEN("KEYWORD"); }
"ate"                        { TOKEN("KEYWORD"); }
"faca"                       { TOKEN("KEYWORD"); }
"leia"                       { TOKEN("KEYWORD"); }
"mostre"                     { TOKEN("KEYWORD"); }
"sim"                        { TOKEN("KEYWORD"); }
"nao"                        { TOKEN("KEYWORD"); }
"retorne"                    { TOKEN("KEYWORD"); }
"funcao"                     { TOKEN("KEYWORD"); }

"{--"                        { comment_start_line = yylineno; BEGIN(COMMENT); }
<COMMENT>"---}"              { BEGIN(INITIAL); }
<COMMENT>\n                  { /* yylineno is updated automatically. */ }
<COMMENT>.                   { /* Ignore comment contents. */ }
<COMMENT><<EOF>>             {
                                printf("LINHA %d: ERRO_LEXICO: comentario sem fechamento\n",
                                       comment_start_line);
                                BEGIN(INITIAL);
                                return 0;
                            }

"#coment"[^\n]*              { /* Single-line comment. */ }
"#"[^\n]*                    { ERROR("comentario deve comecar com #coment"); }

"<="                         { TOKEN("LESS_EQUAL"); }
">="                         { TOKEN("GREATER_EQUAL"); }
"=="                         { TOKEN("EQUAL"); }
"!="                         { TOKEN("NOT_EQUAL"); }
"&&"                         { TOKEN("AND"); }
"||"                         { TOKEN("OR"); }
"<"                          { TOKEN("LESS"); }
">"                          { TOKEN("GREATER"); }
"!"                          { TOKEN("NOT"); }
"="                          { TOKEN("ASSIGN"); }
"+"                          { TOKEN("PLUS"); }
"-"                          { TOKEN("MINUS"); }
"*"                          { TOKEN("TIMES"); }
"/"                          { TOKEN("DIVIDE"); }
"%"                          { TOKEN("MODULO"); }
"("                          { TOKEN("LPAREN"); }
")"                          { TOKEN("RPAREN"); }
"["                          { TOKEN("LBRACKET"); }
"]"                          { TOKEN("RBRACKET"); }
"{"                          { TOKEN("LBRACE"); }
"}"                          { TOKEN("RBRACE"); }
";"                          { TOKEN("SEMICOLON"); }
"$"                          { TOKEN("DOLLAR"); }

{STRING}                     { TOKEN("STRING"); }
"’"[^’\n]*                { ERROR("string sem fechamento"); }
\"[^\"\n]*\"                { ERROR("aspas duplas nao pertencem a MiniLang"); }
{REAL},[0-9,]*               { ERROR("numero real malformado"); }
{INTEGER}"."[0-9]+          { ERROR("o separador decimal deve ser virgula"); }
{INTEGER}{ID}                { ERROR("identificador nao pode comecar com digito"); }
{REAL}                       { TOKEN("REAL"); }
{INTEGER}                    { TOKEN("INTEGER"); }
{ID}                         { TOKEN("IDENTIFIER"); }

[ \t\r\n]+                  { /* Ignore whitespace. */ }
.                            { ERROR("simbolo nao pertence a MiniLang"); }

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
