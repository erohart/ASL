%{
#include "y.tab.h"
#include <string.h>
char* dictionnaireFrancaisAnglais(char* motFrancais);
%}

S ("je"|"tu"|"il"|"elle"|"on"|"nous"|"vous"|"ils"|"I"|"you"|"he"|"she"|"it"|"we"|"they")
V ("etre"|"avoir"|"manger"|"boire"|"be"|"have"|"eat"|"drink"|"suis")
C ("eau"|"gateau"|"crepe"|"pomme"|"fleur"|"water"|"pancake"|"cake"|"apple"|"flower")
Adj ("beau"|"délicieux"|"rouge"|"bleu"|"jaune"|"beautiful"|"delicious"|"red"|"blue"|"yellow")
ND ("ne"|"not")
NF ("pas")
T ("hier"|"lundi"|"mardi"|"mercredi"|"jeudi"|"vendredi"|"samedi"|"dimanche"|"yesterday"|"monday"|"tuesday"|"wednesday"|"thursday"|"friday"|"saturday"|"sunday")
/*
"Je"	{printf("lex:sujet=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return sujet;}
"suis"	{printf("lex:verbe=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return verbe;}
*/


%%

("Je"|"je"|"moi") 	{printf("lex:sujet=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return sujet;}
"suis" 	{printf("lex:verbe=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return verbe;}
"ne" 	{printf("lex:ND=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return negationDebut;}
"pas" 	{printf("lex:NF=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return negationFin;}
"heureux" 	{printf("lex:complement=%s\n", yytext);yylval.string=dictionnaireFrancaisAnglais(yytext);return complement;}
[ \t]	{printf("lex:blanc\n");return blanc;}
"." 	{printf("lex:point\n");return point;}
.	{printf("lex:caractereInconnu\n");yyerror("lex-inconnu\n");return blanc;}

%%

int yywrap(void){
	return 1;
}

char* dictionnaireFrancaisAnglais(char* motFrancais){
	if(strcmp(motFrancais, "Je")==0||strcmp(motFrancais, "je")==0){
		return "I";
	}else if(strcmp(motFrancais, "suis")==0){
		return "am";
	}else if(strcmp(motFrancais, "eau")==0){
		return "water";
	}else if(strcmp(motFrancais, "heureux")==0){
		return "happy";
	}else if(strcmp(motFrancais, "ne")==0){
		return "not";
	}else{
		char* res = malloc(strlen(motFrancais)*sizeof(char));
		strcpy(res, motFrancais); // il faut renvoyer une copie car si le motFrancais est modifié par la suite cela modifiera aussi res. (hors motFrancais peut etre yytext)
		return res;
	}
}
