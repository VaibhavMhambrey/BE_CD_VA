%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 100

typedef struct Symbol {
    char *name;
    char *type;
} Symbol;

Symbol symbol_table[MAX_SYMBOLS];
int symbol_count = 0;

int lookup_symbol(char *name);
void add_symbol(char *name, char *type);

void yyerror(const char *s);
int yylex();
%}

%union {
    char *sval;
}

%token <sval> IDENTIFIER
%token <sval> INT_TYPE FLOAT_TYPE SEMICOLON
%type <sval> type
%token '='
%%

program:
    program declarations 
    |  program assignment
    |
    ;

assignment:
    IDENTIFIER '=' IDENTIFIER SEMICOLON {
        int left_index = lookup_symbol($1);
        int right_index = lookup_symbol($3);

        if (left_index == -1) {
            printf("Error: Variable '%s' is not declared.\n", $1);
        } else if (right_index == -1) {
            printf("Error: Variable '%s' is not declared.\n", $3);
        } else if (strcmp(symbol_table[left_index].type, symbol_table[right_index].type) != 0) {
            printf("Semantic Type Missmatch Error: Cannot assign '%s' to '%s'.\n", symbol_table[right_index].type, symbol_table[left_index].type);
        } else {
            printf("Assignment '%s = %s' is valid.\n", $1, $3);
        }
    }
    ;

declarations:
    declaration declarations  
    | 
    ;

declaration:
    type IDENTIFIER SEMICOLON {
        if (lookup_symbol($2) != -1) {
            printf("Error: Variable '%s' is already declared.\n", $2);
        } else {
            add_symbol($2, $1);
            printf("Added '%s' to symbol table with type '%s'.\n", $2, $1);
        }
    }
    ;

type:
    INT_TYPE { $$ = "int"; }
    | FLOAT_TYPE { $$ = "float"; }
    ;

%%

int lookup_symbol(char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return i;  // Symbol found
        }
    }
    return -1;  // Symbol not found
}

void add_symbol(char *name, char *type) {
    if (symbol_count < MAX_SYMBOLS) {
        symbol_table[symbol_count].name = strdup(name);
        symbol_table[symbol_count].type = strdup(type);
        symbol_count++;
    } else {
        printf("Error: Symbol table overflow.\n");
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    yyparse();
    printf("\nSymbol Table:\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("Name: %s, Type: %s\n", symbol_table[i].name, symbol_table[i].type);
    }
    return 0;
}
