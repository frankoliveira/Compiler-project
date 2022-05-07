%{
#include <stdio.h>
#include <stdlib.h>
#include <cstdlib>
#include <string>
#include <sstream>
#include <iostream>

#define YYSTYPE atributos
using namespace std;

void yyerror(string);
int yylex(void);
int yyparse();

struct atributos
	{
	string nome;
	string traducao;
	string tipo_var;
	string limiteinf;
	string limiteup;
	int contvar;
	int contcom;
	};


string saida;
%}

%token VAR COMANDO INDICE LOR LAND LNOT EOL ABRE FECHA INIC


%%

CLAUSULAS:		INIC CLAUSULAS {
	 				cout << $2.traducao;
					}
 			 | CLAUSULA LAND CLAUSULAS{
	 			$3.traducao=$1.traducao + " * " + $3.traducao;
                                $$.traducao= $3.traducao; 
				}
		        | CLAUSULA EOL { 
					}
        		;

CLAUSULA:	ABRE DENTRO FECHA {
				$$.traducao = "(" + $2.traducao + ")";
				  }
		| COMANDO ABRE VAR INDICE FECHA {
				$$.traducao = $1.traducao + "(" + $3.traducao + $3.limiteinf + $3.limiteup + " " + $4.traducao + ")";
				}
		;
DENTRO	:	VAR LOR DENTRO	{
       	
				
       				$$.traducao = $1.traducao + $1.limiteinf + $1.limiteup  + " + " + $3.traducao;
       				}


		| LNOT VAR LOR DENTRO
				{
				$$.traducao = "!" + $2.traducao + $2.limiteinf + $2.limiteup + " + " + $4.traducao;
				}
		| VAR {

			
				$$.traducao = $1.traducao + $1.limiteinf + $1.limiteup;}
 		| LNOT  VAR {
				
			
				$$.traducao = "!" + $2.traducao + $2.limiteinf + $2.limiteup;
				}

		;

%%

void yyerror(string MSG) {
	
	//cout << MSG << endl;
	exit(0);
}


#include "lex.yy.c"

int yyparse();

int main() {

  yyparse();
  return 0;

}

