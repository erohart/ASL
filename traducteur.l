%{
#include "y.tab.h"
#include <string.h>
void yyerror(char *s);
char* dictionnaireFrancaisAnglais(char* motFrancais);
%}

S ("je"|"Je"|"tu"|"Tu"|"il"|"Il"|"elle"|"Elle"|"on"|"On"|"nous"|"Nous"|"vous"|"Vous"|"ils"|"Ils"|"I"|"you"|"You"|"he"|"He"|"she"|"She"|"it"|"It"|"we"|"We"|"they"|"They")
V ("suis"|"es"|"est"|"sommes"|"etes"|"sont"|"ai"|"as"|"a"|"avons"|"avez"|"ont"|"mange"|"manges"|"mangeons"|"mangez"|"mangent"|"bois"|"boit"|"buvons"|"buvez"|"boivent"|"am"|"are"|"is"|"have"|"has"|"eat"|"eats"|"drink"|"drinks")
C ("eau"|"gateau"|"crepe"|"pomme"|"fleur"|"water"|"pancake"|"cake"|"apple"|"flower")
Adj ("beau"|"delicieux"|"rouge"|"bleu"|"jaune"|"heureux"|"beautiful"|"delicious"|"red"|"blue"|"yellow")
ND ("ne"|"not")
NF ("pas")
T ("hier"|"lundi"|"mardi"|"mercredi"|"jeudi"|"vendredi"|"samedi"|"dimanche"|"yesterday"|"monday"|"tuesday"|"wednesday"|"thursday"|"friday"|"saturday"|"sunday")
P ("."|"!"|"?")


%%

{S} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return sujet;}
{V} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return verbe;}
{Adj} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return adjectif;}
{ND} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return negationDebut;}
{NF} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return negationFin;}
{C} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return complement;}
{T} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return temporalite;}
[ \t]	{return blanc;}
\n 	{return sautLigne;}
{P} 	{yylval.string=yytext;return point;}
.	{yyerror("mot inconnu\n");yylval.string=yytext;return complement;}

%%

int yywrap(void){
	return 1;
}

char* dictionnaireFrancaisAnglais(char* motFrancais){
	if(strcmp(motFrancais, "Je")==0||strcmp(motFrancais, "je")==0){
		return "I";
	}else if(strcmp(motFrancais, "tu")==0 || strcmp(motFrancais, "vous")==0){
		return "you";
	}else if(strcmp(motFrancais, "Tu")==0 || strcmp(motFrancais, "Vous")==0){
		return "You";
	}else if(strcmp(motFrancais, "il")==0){
		return "he";
	}else if(strcmp(motFrancais, "Il")==0){
		return "He";
	}else if(strcmp(motFrancais, "elle")==0){
		return "she";
	}else if(strcmp(motFrancais, "Elle")==0){
		return "She";
	}else if(strcmp(motFrancais, "nous")==0){
		return "we";
	}else if(strcmp(motFrancais, "Nous")==0){
		return "We";
	}else if(strcmp(motFrancais, "ils")==0){
		return "they";
	}else if(strcmp(motFrancais, "Ils")==0){
		return "They";
	}else if(strcmp(motFrancais, "es")==0 || strcmp(motFrancais, "sommes")==0 || strcmp(motFrancais, "etes")==0 || strcmp(motFrancais, "sont")==0){
		return "are";
	}else if(strcmp(motFrancais, "suis")==0){
		return "am";
	}else if(strcmp(motFrancais, "est")==0){
		return "is";
	}else if(strcmp(motFrancais, "ai")==0 || strcmp(motFrancais, "as")==0 || strcmp(motFrancais, "avons")==0 || strcmp(motFrancais, "avez")==0 || strcmp(motFrancais, "ont")==0){
		return "have";
	}else if(strcmp(motFrancais, "a")==0){
		return "has";
	}else if(strcmp(motFrancais, "mange")==0 || strcmp(motFrancais, "manges")==0 || strcmp(motFrancais, "mangeons")==0 || strcmp(motFrancais, "mangez")==0 || strcmp(motFrancais, "mangent")==0){
		return "eat";
	}else if(strcmp(motFrancais, "mange")==0){
		return "eats"; // ne sera jamais utilisé puisque la même condition est juste au dessus. Il faudrait connaitre le contexte (le sujet) pour traduire correctement.
	}else if(strcmp(motFrancais, "bois")==0 || strcmp(motFrancais, "buvons")==0 || strcmp(motFrancais, "buvez")==0 || strcmp(motFrancais, "boivent")==0){
		return "drink";
	}else if(strcmp(motFrancais, "boit")==0){
		return "drinks";
	}else if(strcmp(motFrancais, "eau")==0){
		return "water";
	}else if(strcmp(motFrancais, "gateau")==0){
		return "cake";
	}else if(strcmp(motFrancais, "pomme")==0){
		return "apple";
	}else if(strcmp(motFrancais, "fleur")==0){
		return "flower";
	}else if(strcmp(motFrancais, "beau")==0){
		return "beautiful";
	}else if(strcmp(motFrancais, "delicieux")==0){
		return "delicious";
	}else if(strcmp(motFrancais, "rouge")==0){
		return "red";
	}else if(strcmp(motFrancais, "bleu")==0){
		return "blue";
	}else if(strcmp(motFrancais, "jaune")==0){
		return "yellow";
	}else if(strcmp(motFrancais, "heureux")==0){
		return "happy";
	}else if(strcmp(motFrancais, "delicieux")==0){
		return "delicious";
	}else if(strcmp(motFrancais, "ne")==0){
		return "not";
	}else if(strcmp(motFrancais, "hier")==0){
		return "yesterday";
	}else if(strcmp(motFrancais, "lundi")==0){
		return "monday";
	}else if(strcmp(motFrancais, "mardi")==0){
		return "tuesday";
	}else if(strcmp(motFrancais, "mercredi")==0){
		return "wednesday";
	}else if(strcmp(motFrancais, "jeudi")==0){
		return "thursday";
	}else if(strcmp(motFrancais, "vendredi")==0){
		return "friday";
	}else if(strcmp(motFrancais, "samedi")==0){
		return "saturday";
	}else if(strcmp(motFrancais, "dimanche")==0){
		return "sunday";
	}else if(strcmp(motFrancais, "ne")==0){
		return "not";
	}else{
		char* res = malloc(strlen(motFrancais)*sizeof(char));
		strcpy(res, motFrancais); // il faut renvoyer une copie car si le motFrancais est modifié par la suite cela modifiera aussi res. (hors motFrancais peut etre yytext)
		return res;
	}
}
