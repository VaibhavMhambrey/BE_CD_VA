%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *s);  
int yylex();          
%}

%token NUMBER
%token IDENTIFIER

%left '+' '-'
%left '*' '/'

%%

S: IDENTIFIER'='expr { printf("Valid expression\nResult: %d\n", $3); }
 ;

expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr {
        if ($3 == 0) {
            yyerror("Division by zero");
            exit(1);
        }
        $$ = $1 / $3;
      }
    | '(' expr ')' { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Syntax error: %s\n", s);
}

int main() {
    printf("Enter an expression: ");
    yyparse();  // Start parsing
    return 0;
}
