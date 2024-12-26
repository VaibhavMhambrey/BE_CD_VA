%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *msg);
int yylex();
%}

%union {
    char *str;   // For identifiers and constants
}

%token <str> IDENTIFIER CONSTANT
%token DATATYPE STAR ASSIGN SEMICOLON COMMA PLUS MINUS DIVIDE
%start program

%%
program:
    declarations_and_statements
    ;

declarations_and_statements:
    declarations_and_statements declaration
    |
    declarations_and_statements statement
    |
    declaration
    |
    statement
    ;

declaration:
    DATATYPE pointers_list SEMICOLON {
        printf("Valid pointer declaration.\n");
    }
    ;

pointers_list:
    pointer
    |
    pointers_list COMMA pointer
    ;

pointer:
    pointers IDENTIFIER opt_init {
        printf("Pointer: %s\n", $2);
    }
    ;

pointers:
    STAR pointers
    |
    STAR
    ;

opt_init:
    ASSIGN CONSTANT
    |
    ;

statement:
    IDENTIFIER ASSIGN expression SEMICOLON {
        printf("Assignment: %s\n", $1);
    }
    ;

expression:
    term
    |
    expression PLUS term
    |
    expression MINUS term
    |
    expression DIVIDE term
    ;

term:
    factor
    |
    STAR factor
    |
    STAR STAR factor
    |
    STAR STAR STAR factor
    ;

factor:
    IDENTIFIER
    |
    CONSTANT
    ;
%%
void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

int main() {
    printf("Enter your code: ");
    return yyparse();
}
