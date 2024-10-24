%{
#include<stdlib.h>
#include<stdio.h>
int yylex(void);
void yyerror(char*);
%}


%token ID
%token FLOAT INT 

%%

S : D V '\n'        { printf("Valid statement");       }
  ;

D : INT 	{		} 
    | FLOAT     {		}
    ;

V : ID ';'  	{                }
  | ID ',' V 	{		}
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

