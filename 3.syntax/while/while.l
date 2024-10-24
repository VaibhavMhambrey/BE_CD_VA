%{
    #include "while.tab.h"
    void yyerror(char*);
%}

alpha [a-zA-Z_]
digit[0-9]

%%

"while" { return WHILE;}
"<=" { return LTE;}
">="  {return GTE;}
{digit}|{alpha}({alpha}|{digit})* {return ID;}
[(),;\n] { return *yytext;}
[=]       { return *yytext;}
[{}]       { return *yytext;}
[<>]        { return *yytext;}
[ \t] {;}
[+-] {return *yytext;}

.  {yyerror("invalid character"); exit(0);}


%%

int yywrap(void)
{
    return 1;
}