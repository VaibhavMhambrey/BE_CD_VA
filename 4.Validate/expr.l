%{
#include "expr.tab.h"  
void yyerror(char *); 
%}

%%
[0-9]+   { yylval = atoi(yytext); return NUMBER; }  
"="       { return '='; }
"+"       { return '+'; }
"-"       { return '-'; }
"*"       { return '*'; }
"/"       { return '/'; }
"("       { return '('; }
")"       { return ')'; }
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[ \t]+  
\n        { return 0; }  
.         { printf("Invalid character %s",yytext); exit(1); }

%%

int yywrap() { return 1; }
