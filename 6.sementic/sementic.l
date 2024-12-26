%{
#include "expt6.tab.h"
%}

%%
int       { return INT_TYPE; }
float     { return FLOAT_TYPE; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return IDENTIFIER; }
;         { return SEMICOLON; }
"="       {return '=';}
[ \t\n]   { /* Ignore whitespace */ }
.         { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
