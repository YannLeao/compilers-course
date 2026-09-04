%define parse.error detailed
%define parse.trace

%{

#include <stdio.h>

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

%}

%token STRING NUMBER
%token TRUE FALSE NULL_TOKEN
%token INVALID

%%

document : value
         ;

value    : STRING
         | NUMBER
         | TRUE
         | FALSE
         | NULL_TOKEN
         | array
         | object
         ;

array    : '[' ']'
         | '[' elements ']'
         ;

elements : value
         | elements ',' value
         ;

object   : '{' '}'
         | '{' members '}'
         ;

members  : pair
         | members ',' pair
         ;

pair     : STRING ':' value
         ;

%%

void yyerror(const char *message)
{
  (void)message;
}

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("JSON COM ERRO\n");
        return 1;
    }

    FILE *file = fopen(argv[1], "r");

    if (file == NULL) {
        printf("JSON COM ERRO\n");
        return 1;
    }

    yyin = file;
    int result = yyparse();
    fclose(file);

    if (result == 0) {
        printf("JSON OK\n");
    } else {
        printf("JSON COM ERRO\n");
    }

    return result == 0 ? 0 : 1;
}
