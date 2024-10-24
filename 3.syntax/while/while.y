%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    void yyerror(char*);
%}

%token ID
%token WHILE
%token LTE
%token GTE

%%

S : WHILE '(' cond ')' '{' stmt_list '}' '\n' { printf("Valid Statement\n");}
;
cond : ID relop ID { printf("Condition Checked\n"); }
;
relop : '<' | '>' | LTE | GTE { printf(" Relational Op Used\n"); }
;
stmt_list: stmt ';' stmt_list | stmt ';'
;
stmt: ID '=' EXP { printf("Assignment statement\n"); }
    | ID { printf("Variable\n"); }
;
EXP: EXP '+' EXP | EXP '-' EXP | EXP '*' EXP | ID
;

%%

void yyerror(char* s)
{
    fprintf(stderr,"%s",s);
}

int main()
{
    yyparse();
    return 0;
}