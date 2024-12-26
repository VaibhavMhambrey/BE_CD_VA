%{
#include "expt8.tab.h"
%}

%%

[0-9]+          { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]*  { yylval.sval = strdup(yytext); return IDENTIFIER; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULTIPLY; }
"/"             { return DIVIDE; }
";"             {return SC;}
[ \t\n]         { /* Ignore whitespace */ }

.               { printf("Unknown character: %s\n", yytext); }

%%
int yywrap() { return 1; }
