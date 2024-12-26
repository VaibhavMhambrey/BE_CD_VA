%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
extern char *yytext; // To capture the text causing the error
%}

%token CREATE TRIGGER BEFORE AFTER INSERT UPDATE DELETE ON FOR EACH ROW BEGIN_BLOCK END IDENTIFIER SEMICOLON

%%

trigger_definition:
    CREATE TRIGGER IDENTIFIER timing_event ON IDENTIFIER FOR EACH ROW statements   {printf("Trigger definition is correct!!");}
    ;

timing_event:
    BEFORE event
  | AFTER event
    ;

event:
    INSERT
  | UPDATE
  | DELETE
    ;

statements:
    BEGIN_BLOCK statement_list END SEMICOLON
    ;

statement_list:
    /* empty */
  | statement_list statement
    ;

statement:
    IDENTIFIER SEMICOLON
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s at '%s'\n", s, yytext);
}

int main() {
    printf("Enter a trigger definition:\n");
    return yyparse();
}
