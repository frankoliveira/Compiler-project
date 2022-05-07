%{
#include <stdio.h>
#include <stdlib.h>
#include "st.h"
int yylex(void);
void yyerror(char* message);


%}

%union{double f; struct vec v;}

%token <f> NUM
%token FIM_LINHA
%token VEC
%type <v> expression term vector 
%type <f> no
%left '+' '-'
%left '*'

%%
program : 
    linha program {;}
    | linha       {;};

linha: expression FIM_LINHA { printf("valor: %lf, %lf, %lf\n", $1.x, $1.y, $1.z); };

expression:     expression '+' term  { $$.x = $1.x + $3.x; $$.y = $1.y + $3.y; $$.z = $1.z + $3.z;}
                | expression '-' term { $$.x = $1.x - $3.x; $$.y = $1.y - $3.y; $$.z = $1.z - $3.z;}
                | term {$$.x = $1.x; $$.y = $1.y; $$.z = $1.z;}
                ;              

term:           vector '*' no { $$.x = $1.x * $3; $$.y = $1.y * $3; $$.z = $1.z * $3;}
                | no '*' vector { $$.x = $3.x * $1; $$.y = $3.y * $1; $$.z = $3.z * $1;}
                | vector { $$.x = $1.x; $$.y = $1.y; $$.z = $1.z; }
                ;

vector:         'V''e''c''(' no ',' no ',' no ')' { $$.x = $5;  $$.y = $7; $$.z = $9; }
                | '[' no ',' no ',' no ']' { $$.x = $2; $$.y = $4; $$.z = $6; }
                ;

no:             NUM {$$ = $1;};


%%

int main(int argc, char** argv) {
    return yyparse();
}
void yyerror(char* message) {
    fprintf(stderr, "Erro: %s\n", message);
}