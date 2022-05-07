%{
#include <stdio.h>
#include <stdlib.h>
#include "st.h"
#include "y.tab.h"
%}

%%

[ \t]		;
[-]?[0-9]+("."[0-9]+)?     yylval.f = atof(yytext); return NUM;
"\n"                        return FIM_LINHA;
"+"                         return '+';
"-"                         return '-';
"*"                         return '*';
"("                         return '(';
")"                         return ')';
"["         return '[';
"]"         return ']';
","         return ',';
"V"         return 'V';
"e"         return 'e';
"c"         return 'c';     
.		    printf("Erro\n");

%%

int yywrap(void) {
    return 1;
}




