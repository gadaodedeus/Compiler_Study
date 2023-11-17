
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;
extern int yycolumn;
extern FILE* yyin;
%}

%union {
    int num;
    char* str;
}

%token EQUAL
%token <num> NUMBER
%token <str> NAME
%token FDL
%token SIMBOLO
%token SIMBOLOL
%token SIMB
%token IF
%token WHILE
%token ELSE
%token OPEN_PAR
%token CLOSE_PAR


%%

input:
    | line input

line:
    NAME FDL { printf("Nome: %s\n", $1);} 
    | FDL
    | comandoif 
    | comandowhile
    | comandoatrib
    | cond


cond:
    NAME SIMBOLOL cond
    | NUMBER SIMBOLOL cond
    | NAME
    | NUMBER

comandoif:
    IF OPEN_PAR cond CLOSE_PAR {printf("Desvio condicional IF\n");}
    | IF OPEN_PAR cond CLOSE_PAR ELSE { printf("Desvio condicional IF-ELSE\n"); }


comandowhile:
    WHILE OPEN_PAR cond CLOSE_PAR { printf("Loop while\n"); }

comandoatrib:
    NAME EQUAL NUMBER { printf("Atribuição\n");}
    | NAME EQUAL NUMBER SIMBOLO NUMBER {printf("Atribuição\n");}
    | NAME EQUAL NAME {printf("Atribuição\n");}
    | NAME EQUAL NAME SIMBOLO NUMBER {printf("Atribuição\n");}
    | NAME NAME EQUAL NUMBER {printf("Declaração\n");}
    | NAME NAME EQUAL NUMBER SIMBOLO NUMBER {printf("Declaração\n");}
    | NAME NAME EQUAL NAME {printf("Declaração\n");}
    | NAME NAME EQUAL NAME SIMBOLO NUMBER {printf("Declaração\n");}

%%

int main()
{
    printf("Insira o nome do arquivo que deseja ler: ");
    char file_name[40];
    scanf("%s", file_name);
    
    
    FILE* filein = fopen(file_name, "r");
    if(!filein){
        printf("ERRO: arquivo não encontrado\n");
        return 0;
    }
    yyin = filein;
    yyparse();
    return 0;
}

int yyerror(char* se)
{
    
    printf("Erro na linha %d, coluna %d: %s\n", yylineno, yycolumn, se);
    return 0;
}
