#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int size_base = 8;
char *setWord(char *str);

int main(void){
        
    char *word = setWord("01110000");
    printf("palavra final: %s",word);
    free(word);
    return 0;
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
    int i = 0, j=0, k=0, len = sizeof(str);

    if( (len%size_base) != 0){ return NULL; }
    
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

    free(temp);
    return natural_word;
}