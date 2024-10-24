%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char*);
%}

%token ID
%token PLUS
%token MINUS
%token LTE
%token GTE
%token FOR
%token INT

%%

S: FOR '(' init ';' cond ';' incr ')' '{' stmt_list '}' '\n' { printf("Valid for loop statement\n"); }
;

init: ID '=' ID { printf("Initialization\n"); }
;

cond: ID relop ID { printf("Condition checked\n"); }
;

incr: ID PLUS { printf("Increment operation\n"); }
    | ID MINUS { printf("Decrement operation\n"); }
    | PLUS ID {printf("prefix increment\n"); }
    | MINUS ID {printf("prefix decrement \n")}
;

relop: '>' | '<' | GTE | LTE { printf("Relational operator used\n"); }
;
stmt_list: ID '=' ID
;

%%

void yyerror(char* s)
{
    fprintf(stderr, "%s\n", s);
}

int main()
{
    yyparse();
    return 0;
}
