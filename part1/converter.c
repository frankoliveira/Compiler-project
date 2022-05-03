#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int size_base = 4;
char *setWord(char *str);

int main(void){
        
    char *word = setWord("0141014201410143");
    printf("palavra final: %s",word);
    free(word);
    return 0;
}

char setChar(char string[]){
    char result;

    if(strcmp("0141",string) == 0){
        result =  'a';
    }
    else if(strcmp("0142",string) == 0){
        result =  'b';
    }
    else if(strcmp("0143",string) == 0){
        result =  'c';
    }
    return result;
}

char *setWord(char *str){
    int len = sizeof(str);
    printf("%d:", len);

    int i = 0, j=0, k=0;
        
    if( (len%size_base) != 0){ return NULL; }
        
    char *temp = (char *) malloc(size_base * sizeof(char));
    int n_len = len/size_base;
    char *natural_word = (char *)malloc(n_len * sizeof(char));

    while(str[i] != '\0'){
        for(j=0; j<size_base; j++){
            temp[j] = str[i++];
        }
        natural_word[k] = setChar(temp);
        k++;
    }
    
    free(temp);
    return natural_word;
}