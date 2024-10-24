%{
#include "for.tab.h"
void yyerror(char*);
%}

alpha [a-zA-Z_]
digit[0-9]

%%
"for"   { return FOR;} 

"int" {return INT;}
"++"  {return PLUS;}
"--"  {return MINUS;}
"<="  {return LTE;}
">="  {return GTE;}

{digit}|{alpha}({alpha}|{digit})* {return ID;}

[(),;\n] { return *yytext;}
[=]       { return *yytext;}
[{}]       { return *yytext;}
[<>]        { return *yytext;}
[+-]        {return *yytext;}
[ \t] {;}
.  {yyerror("invalid character"); exit(0);}
%%
int yywrap(void)
{return 1;}