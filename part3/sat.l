%{
#include <stdlib.h>
#include <string>

//extern "C" int yylex();
int var = 0, comand=0;
//#include "satmais.tab.hpp"

%}
%option noyywrap

AP \(
FP \)
%%


[@]	{
	return INIC;
	}
[A-Z][0-9][0-9] {
		yylval.nome = yytext[0];
		yylval.traducao = yytext[0];
		yylval.limiteinf = yytext[1];
		yylval.limiteup = yytext[2];
		yylval.contvar = var;
		var++;
        	return VAR;
	        }

[A-Z]+	{
	yylval.nome = yytext;
	yylval.traducao = yytext;
	yylval.contcom = comand;
	comand++;
	return COMANDO;
	}

[1-2] 	{
	yylval.traducao = yytext;
	return INDICE;
	}

[+]   {
          return LOR;
        }


[*]    {
          return LAND;
        }

[!]	{
	return LNOT;
	}


[\n]   {
         return EOL;
       }

[ \t]+ {;}

{AP}	{
	return ABRE;
	}

{FP}	{
	return FECHA;
	}

.     {
	exit(0);
	//yyerror("Token nao reconhecido!\n");
	}

%%

//void yyerror(string MSG)
//	{
//	cout << MSG << endl;
//	exit(0);
//	}

//int yywrap() {
//  return 1;
//}
