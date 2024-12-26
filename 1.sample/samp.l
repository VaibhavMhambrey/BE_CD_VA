%{
#include<stdio.h>
%}
letters[a-zA-Z]
digit[0-9]

%%
{letters}({letters}|{digit})* {printf("Variable: %s\n",yytext);}
{digit}+                      {printf("Interger type %s\n",yytext);}
{digit}+"."{digit}+              {printf("Float type %s\n",yytext);}
%%

void main(){
    yylex();
}

int yywrap() {
return 1;
}
