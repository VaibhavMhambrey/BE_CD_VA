%{
#include<stdio.h>
%}

%%

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { printf("Keyword: %s\n", yytext); }
\{ | \} | \[ | \] | , | ; { printf("Delimiter: %s\n", yytext); }
\( | \) { printf("Circular brackets\n"); }
"+"|"*"|"-"|"/"|"++"|"--"|"%" { printf("Operator %s\n",yytext); }
"="|"<="|">="|">"|"<"|"=="|"!="  { printf("Relational operator: %s\n",yytext); }
"&&"|"||"|"!" { printf("logical operator: %s\n",yytext); }
[0-9]+ { printf("Integer: %s\n", yytext); }
[0-9]+"."[0-9]+ { printf("Float: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Identifier: %s\n", yytext); }
\"([^\\\"]|\\.)*\" { printf("String Literal: %s\n", yytext); }
\/\/[^\n].* { printf("Comment %s\n",yytext); }
\/\*([^*]|\*+[^/*])*\*+\/ { printf("Comment: %s\n", yytext); }
[ \t\n]+	{ }
";"			{ printf("Semicolon character \n"); }
.			{ printf("Unknown character %s\n", yytext); }

%%

int main()
{
	yylex();
	return 0;
}

