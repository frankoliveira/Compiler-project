%{
/*Declarações*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int size_base = 8;
char setChar(char string[]);
char *setWord(char *str);
%}

/*Definições Regulares*/
%option yylineno
bin ([01]{8})+

%%

[ \n\t] ; 
{bin} {printf("OUTPUT: %s\n", setWord(yytext)); }
. printf("Error at line %d\n", yylineno);

%%

/*Funções Auxiliares*/
int yywrap()
{
    return 1;
}

int main(int argc, char *argv[ ] ){
    
    size_base = 8;  
    extern FILE *yyin;

    yyin=fopen("input.txt", "r");
    
    yylex();
}

char setChar(char string[]){
    char character = 0;
    int i, num_char=0, exponent = size_base-1;

    for(i=0; string[i] != '\0'; i++, exponent--){
        if(string[i] == '1'){   num_char += (int)(pow(2.0,(double)exponent));   }
    }

    return (character+num_char);
}

char *setWord(char *str){

    int i = 0, j=0, k=0, len = strlen(str);    
    int n_len = len/size_base;

    char *temp = (char *) malloc(size_base * sizeof(char));
    char *natural_word = (char *)malloc(n_len * sizeof(char));

    while(str[i] != '\0'){
        for(j=0; j<size_base; j++){
            temp[j] = str[i++];
        }
        natural_word[k] = setChar(temp);
        k++;
    }
    
    natural_word[n_len] = '\0';
    free(temp);
    return natural_word;
}