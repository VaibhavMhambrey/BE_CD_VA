%{
#include "exp7.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}
alpha [a-zA-Z_]
digit [0-9]
%%
if                  { return IF; }
[\t\n ]+            { /* Ignore whitespace */ }
[()]                { return *yytext; }
[{}]                { return *yytext; }
"="                 { return '='; }
[-+*]               { return *yytext; }
";"                 { return SC; }
{digit}|{alpha}({alpha}|{digit})* { yylval.string_value = strdup(yytext); return ID; }
">"|"<"|">="|"<="|"!="|"=="       { yylval.string_value = strdup(yytext); return OP; }
%%
