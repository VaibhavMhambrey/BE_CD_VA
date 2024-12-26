%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h> 
void yyerror(const char *s);
int yylex();

int temp_var_count = 1; // Counter for temporary variables

// Function to generate a new temporary variable name
char* new_temp() {
    char* temp = (char*)malloc(8);
    sprintf(temp, "t%d", temp_var_count++);
    return temp;
}

%}

%union {
    int ival;      // For integer constants
    char *sval;    // For identifiers or temporary variable names
}

%token <ival> NUMBER
%token <sval> IDENTIFIER
%token PLUS MINUS MULTIPLY DIVIDE
%type <sval> expr term factor

%token SC
%%

stmt:
    expr SC{ /* Do nothing here */ }
    ;

expr:
    expr PLUS term {
        if ($1 && $3 && isdigit($1[0]) && isdigit($3[0])) {
            // Constant folding
            int result = atoi($1) + atoi($3);
            char buffer[10];
            sprintf(buffer, "%d", result);
            $$ = strdup(buffer);
        } else {
            // Generate three-address code
            char* temp = new_temp();
            printf("%s = %s + %s\n", temp, $1, $3);
            $$ = temp;
        }
    }
    | expr MINUS term {
        if ($1 && $3 && isdigit($1[0]) && isdigit($3[0])) {
            // Constant folding
            int result = atoi($1) - atoi($3);
            char buffer[10];
            sprintf(buffer, "%d", result);
            $$ = strdup(buffer);
        } else {
            // Generate three-address code
            char* temp = new_temp();
            printf("%s = %s - %s\n", temp, $1, $3);
            $$ = temp;
        }
    }
    | term { $$ = $1; }
    ;

term:
    term MULTIPLY factor {
        if ($1 && $3 && isdigit($1[0]) && isdigit($3[0])) {
            // Constant folding
            int result = atoi($1) * atoi($3);
            char buffer[10];
            sprintf(buffer, "%d", result);
            $$ = strdup(buffer);
        } else {
            // Generate three-address code
            char* temp = new_temp();
            printf("%s = %s * %s\n", temp, $1, $3);
            $$ = temp;
        }
    }
    | term DIVIDE factor {
        if ($1 && $3 && isdigit($1[0]) && isdigit($3[0])) {
            // Constant folding
            int result = atoi($1) / atoi($3);
            char buffer[10];
            sprintf(buffer, "%d", result);
            $$ = strdup(buffer);
        } else {
            // Generate three-address code
            char* temp = new_temp();
            printf("%s = %s / %s\n", temp, $1, $3);
            $$ = temp;
        }
    }
    | factor { $$ = $1; }
    ;

factor:
    NUMBER {
        char buffer[10];
        sprintf(buffer, "%d", $1);
        $$ = strdup(buffer);
    }
    | IDENTIFIER {
        $$ = $1;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions :\n");
    yyparse();
    return 0;
}
