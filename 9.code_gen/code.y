%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int yylex(void);
void yyerror(char*);
void Gen(char*);

int i=1,c=0,j,f,count=0,prev,label=100;
char *Array[10][10],*temp,temp1[50],temp2[50];

int lineNo = 0;

int yydebug = 0;

extern FILE *yyin;
%}

%union {
   char *string_value;
   int intVal;
}

%type <string_value> Exp S Cond
%type <intVal> Stmt Exp1 
%token IF 
%token <string_value> ID 
%token <string_value> INTEGER RELOP
%start S

%left '+' '-'
%left '*' '/'
%left '='


%%

S : IF '(' Cond ')' '{' Stmt '}'   {  $$="t"; Gen(temp2);sprintf(temp2,"\n%d]if not %s, jmp %d\n", lineNo++,$3, $6); Gen(temp2);printf("%s\n", temp2); exit(0);  }

Cond : ID RELOP ID                 { sprintf($$, "%s %s %s", $1, $2, $3);}


Stmt : Stmt Exp1 ';'               { $$ = $2 + 1;}
     |                             { }


Exp1 :ID '=' Exp    {   $$=lineNo + 1; Gen(temp2);sprintf(temp2,"\n%d]mov %s, %s\n", lineNo++,$1,$3); Gen(temp2);printf("%s", temp2); }


Exp  : Exp '+' Exp  {    $$="t";sprintf(temp2,"\n%d]mov A, %s;add A, %s; mov t, A;", lineNo++, $1, $3);Gen(temp2); printf("%s", temp2);}
     | Exp '-' Exp  {    $$="t";sprintf(temp2,"\n%d]mov A, %s;sub A, %s; mov t, A;", lineNo++, $1, $3);Gen(temp2);printf("%s", temp2);}
     | Exp '*' Exp  {    $$="t";sprintf(temp2,"\n%d]mov A, %s;mul A, %s; mov t, A;", lineNo++, $1, $3);Gen(temp2);printf("%s", temp2);}
     | ID	          {    $$=$1;	}
     | INTEGER	     {    $$=$1;  }
     ;  

%%


void Gen(char *val)
{
	FILE *f;
	f=fopen("output.txt","a");
	fputs(val,f);
	fclose(f);
}

int yywrap() { return 1; }

void yyerror(char *s)
{
}

int main( int argc, char **argv ) {
	yyparse();
	return 1;
}

