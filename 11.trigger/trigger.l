%{
#include "trigger.tab.h"
extern char *yytext; 
%}

%option noyywrap

%%

[ \t\n]+        { /* Ignore whitespace */ }
CREATE          { return CREATE; }
TRIGGER         { return TRIGGER; }
BEFORE          { return BEFORE; }
AFTER           { return AFTER; }
INSERT          { return INSERT; }
UPDATE          { return UPDATE; }
DELETE          { return DELETE; }
ON              { return ON; }
FOR             { return FOR; }
EACH            { return EACH; }
ROW             { return ROW; }
BEGIN_BLOCK     { return BEGIN_BLOCK; }
END             { return END; }
[;]             { return SEMICOLON; }
[()]            { return *yytext; }
[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
.               { return yytext[0]; }

%%
