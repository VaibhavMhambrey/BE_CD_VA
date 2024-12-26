%{
#include "exp9.tab.h"
#include<stdio.h>
%}

%%

"if"                          {return IF;}

[\t ]+                        /* ignore  the blank spaces */ ;

">"|"<"|">="|"<="|"!="|"=="	{yylval.string_value = strdup(yytext) ;return RELOP;}

[-+*=\n,;(){}]		            {	return *yytext;   }

[a-zA-Z]+                     {    // return valid tokens to yacc program 
                                    yylval.string_value = strdup(yytext );
                                    return ID;               };

[0-9]+		                  {    // return valid tokens to yacc program 
                                    yylval.string_value = strdup(yytext );
                                    return INTEGER;          };	
%%
