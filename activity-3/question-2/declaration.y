%define parse.error detailed
%define parse.trace
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;

typedef struct {
    char *id;
    const char *type;
} Declaration;

#define MAX_TABLE_LENGTH 100

static Declaration table[MAX_TABLE_LENGTH];
static size_t table_length = 0;
static const char *current_type;

static int find_declaration(const char *id) {
    for (size_t i = 0; i < table_length; i++) {
        if (strcmp(table[i].id, id) == 0) {
            return (int)i;
        }
    }
    return -1;
}

static void declare_variable(const char *type, char *id) {
    int position = find_declaration(id);

    if (position >= 0) {
        printf("erro: %s já foi declarada\n", id);
        free(id);
        return;
    }

    if (table_length >= MAX_TABLE_LENGTH) {
        fprintf(stderr, "declarations limit exceeded\n");
        free(id);
        return;
    }

    table[table_length].id = id;
    table[table_length].type = type;
    table_length++;

    printf("%s %s\n", type, id);
}

void free_table(void) {
    for (size_t i = 0; i < table_length; i++) {
        free(table[i].id);
    }
}

%}

%union {
    const char *type;
    char *identifier;
}

%destructor { free($$); } <identifier>

%token <type> TYPE
%token <identifier> ID
%token COMMA SEMICOLON

%%
input       : %empty
            | input declaration
            ;
declaration : TYPE { current_type = $1; } id_list SEMICOLON
            ;

id_list     : ID                { declare_variable(current_type, $1); }
            | id_list COMMA ID  { declare_variable(current_type, $3); }
            ;
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

    if (result == 0) {
          printf("+++++ %zu variáveis declaradas\n", table_length);
    }

    free_table();
    return result;
}
