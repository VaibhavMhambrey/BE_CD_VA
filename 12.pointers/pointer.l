%{
#include "pointer.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%option noyywrap


%%
"int"|"float"|"char"      { return DATATYPE; }
"*"                       { return STAR; }
"="                       { return ASSIGN; }
";"                       { return SEMICOLON; }
","                       { return COMMA; }
"+"                       { return PLUS; }
"-"                       { return MINUS; }
"/"                       { return DIVIDE; }
[0-9]+                    { yylval.str = strdup(yytext); return CONSTANT; }
[a-zA-Z_][a-zA-Z0-9_]*    { yylval.str = strdup(yytext); return IDENTIFIER; }
[ \t\n]                   { /* Ignore whitespace */ }
.                         { printf("Unknown character: %c\n", *yytext); }
%%
