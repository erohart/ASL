%{
#include "y.tab.h"
#include <string.h>
char* dictionnaireFrancaisAnglais(char* motFrancais);
%}

%%

"Je"	{printf("lex:sujet=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return sujet;}
"suis"	{printf("lex:verbe=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return verbe;}
[ \t]	{printf("lex:blanc\n");return blanc;}
"." 	{printf("lex:point\n");return point;}
.	{printf("lex:caractereInconnu\n");yyerror("lex-inconnu\n");return blanc;}

%%

int yywrap(void){
	return 1;
}

char* dictionnaireFrancaisAnglais(char* motFrancais){
	printf("DansFct:%s\n", motFrancais);
	if(strcmp(motFrancais, "Je")==0||strcmp(motFrancais, "je")==0){
		return "I";
	}else if(strcmp(motFrancais, "suis")==0){
		return "am";
	}else{
		return "motInconnu";
	}
}
