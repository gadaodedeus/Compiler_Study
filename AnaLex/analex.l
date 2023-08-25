%{
    #include<stdio.h>
    #include<string.h>
    int line=1;
%}
EXT {ID}".gm"

ID [a-z][a-z0-9_]*
DIGIT [0-9]+
WORD [a-zA-Z]+
WHITSPC [ ]+
ENTER [\n]+
TAB [\t]
EQUAL [=]

%%
"#"[^\n]* {printf("Comment\n");}

{EQUAL} {printf("Assignment\n");}
{WHITSPC} {printf("Whitespace\n");}
{TAB} {printf("Tab\n'");}
    
{ID}+ {printf("ID: %s\n", yytext);}
{DIGIT}+{ID} {printf("\tERROR: Invalid ID %s. Line %d  \n", yytext, line);}

{DIGIT} {printf("Digit: %s\n", yytext);}
{WORD} {printf("Word: %s\n", yytext);}

"+"|"-"|"*"|"/"|"%"|"++"|"--"|"+="|"-=" {printf("Arithimetic Symbol: %s\n", yytext);}

NOT|"!"|AND|"&"|OR|"|"|"<"|"<="|">"|">="|"=="|"!=" {printf("Logical Symbol: %s\n", yytext);}

"'"|"("|")"|"["|"]"|";"|","|"->"|"{"|"}" {printf("Symbol: %s\n", yytext);}


\n {line++;}

. {printf("\tERROR: Invalid token %s. Line %d  \n", yytext, line);}
%%

yywrap() {}

int main(){
    printf("Source code file name: ");
    char* file_name;
    scanf("%s", file_name);
    int aux = strlen(file_name);

    while(file_name[aux-1] != 103 && file_name[aux-2] != 109 && file_name[aux-3] != 46){
        printf("Source file must end with '.mg'!");
        scanf("%s", file_name);
        aux = strlen(file_name);
    }
    
    FILE* filein = fopen(file_name, "r");
    if(!filein){
        printf("ERROR: File not found on directory!\n");
        return 0;
    }
    
    yyin = filein;
    yylex();
    
    return 0;
}
