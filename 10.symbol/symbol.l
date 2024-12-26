%{
#include "exp10.tab.h"  
#include <stdlib.h>
#include <string.h>
%}

%%

"int"           { return INT; }
"float"         { return FLOAT; }
"char"          { return CHAR; }
";"             {return SEMICOLON;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.strVal = strdup(yytext);  return IDENTIFIER; }
[ \t\n]         {  }
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
