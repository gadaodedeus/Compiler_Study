%{
#include<stdio.h>

int yycolumn = 1;
#include "anasin.tab.h"
%}


%%

"#"[^\n]* {continue;}
" "+ {continue;}
"\t" {continue;}

"+"|"-"|"*"|"/"|"%" {return SIMBOLO;}

"|"|"!"|"&"|"<"|"<="|">"|">="|"=="|"!=" {return SIMBOLOL;}

"(" {return OPEN_PAR;}

")" {return CLOSE_PAR;}

"'"|"["|"]"|";"|","|"->"|"{"|"}" {return SIMB;}

[0-9] {yylval.num = atoi(yytext); return NUMBER;}
"=" {return EQUAL;}
"\n" {yylineno++; yycolumn = 1; return FDL;} //fdl = fim de linha
"while" {return WHILE;}
"if" {return IF;}
"else" {return ELSE;}
[a-zA-Z][a-zA-Z0-9_]* {yylval.str = strdup(yytext); return NAME;}


. {
    
    yycolumn++;
    
}
%%

int yywrap() {}

