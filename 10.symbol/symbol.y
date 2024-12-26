%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();

#define MAX_SYMBOLS 100

typedef struct {
    char name[50];
    char type[50];
} Symbol;

Symbol symbolTable[MAX_SYMBOLS];
int symbolCount = 0;

void insertSymbol(char* name, char* type) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].name, name) == 0) {
            strcpy(symbolTable[i].type, type);
            return;
        }
    }

    strcpy(symbolTable[symbolCount].name, name);
    strcpy(symbolTable[symbolCount].type, type);
    symbolCount++;
}

void printSymbolTable() {
    printf("\nSymbol Table:\n");
    printf("Name\tType\n");
    for (int i = 0; i < symbolCount; i++) {
        printf("%s\t%s\n", symbolTable[i].name, symbolTable[i].type);
    }
}


void yyerror(char *s);

%}

%union {
    char* strVal;
}

%token <strVal> IDENTIFIER
%token INT FLOAT CHAR SEMICOLON

%%

program:
    declarations
    ;

declarations:
    declarations declaration
    | declaration
    ;

declaration:
    INT IDENTIFIER SEMICOLON {
        insertSymbol($2, "int");
    }
    | FLOAT IDENTIFIER SEMICOLON {
        insertSymbol($2, "float");
    }
    | CHAR IDENTIFIER SEMICOLON{
        insertSymbol($2, "char");
    }
    ;

%%

int main() {
    printf("Enter your declarations:\n");
    yyparse();
    printSymbolTable();
    return 0;
}

void yyerror(char *s) {
    printf("Syntax error: %s\n", s);
}
