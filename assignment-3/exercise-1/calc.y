%define parse.error detailed
%define parse.trace

%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int  yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

typedef struct {
    char *name;
    double value;
} Variable;

#define MAX_VARIABLES 100

Variable variables[MAX_VARIABLES];
size_t variable_count = 0;

static int find_variable(const char *name) {
    for (size_t i = 0; i < variable_count; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return (int)i;
        }
    }
    return -1;
}

static double get_variable(const char *name) {
    int position = find_variable(name);

    if (position < 0) {
      fprintf(stderr, "Variable not defined: %s\n", name);
      return 0;
    }

    return variables[position].value;

}

/* Takes ownership of name. */
static void set_variable(char *name, double value) {
    int position = find_variable(name);

    if (position < 0) {
        if (variable_count >= MAX_VARIABLES) {
            fprintf(stderr, "Variable limit exceeded\n");
            free(name);
            return;
        }
        variables[variable_count].name = name;
        variables[variable_count].value = value;
        variable_count++;
        return;
    }

    variables[position].value = value;
    free(name);
}

static void print_variables(void) {
    for (size_t i = 0; i < variable_count; i++) {
        printf("%s >>> %g\n", variables[i].name, variables[i].value);
    }
}

static void free_variables(void) {
    for (size_t i = 0; i < variable_count; i++) {
        free(variables[i].name);
    }
}
%}

%union {
    double val;
    char *string;
}

%destructor { free($$); } <string>

%token <val> NUM
%token <string> ID
%token MAIS MENOS VEZES DIVISAO ABRE_PAREN FECHA_PAREN POT ASSIGN PRINT
%type  <val> expr

%left  MAIS MENOS
%left  VEZES DIVISAO
%precedence UMINUS
%right POT

%%
entrada : %empty
        | entrada expr '\n'         { printf("= %g\n", $2); }
        | entrada assign '\n'       {  }
        | entrada PRINT '\n'        { print_variables(); }
        ;

expr : NUM                          { $$ = $1; }
     | ID                           {
                                        $$ = get_variable($1);
                                        free($1);
                                    }
     | expr MAIS expr               { $$ = $1 + $3; }
     | expr MENOS expr              { $$ = $1 - $3; }
     | expr VEZES expr              { $$ = $1 * $3; }
     | expr DIVISAO expr            { $$ = $1 / $3; }
     | expr POT expr                { $$ = pow($1, $3); }
     | MENOS expr %prec UMINUS      { $$ = -$2; }
     | ABRE_PAREN expr FECHA_PAREN  { $$ = $2; }
     ;

assign : ID ASSIGN expr             { set_variable($1, $3); }
%%

void yyerror(const char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char **argv)
{
    FILE *file = NULL;

    if (argc > 1) {
        file = fopen(argv[1], "r");

        if (file == NULL) {
            perror("Error opening the file");
            return 1;
        }

        yyin = file;
    }

    int result =  yyparse();

    if (file != NULL) {
      fclose(file);
    }

    free_variables();
    return result;
}
