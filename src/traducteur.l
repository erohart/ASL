%{
#include "y.tab.h"
#include <string.h>
#include <ctype.h>
void yyerror(char *s);
char* dictionnaireFrancaisAnglais(char* motFrancais);
int comparaisonSansMajuscule(char* str1, char* str2);
%}

S (?i:"je"|"tu"|"il"|"elle"|"on"|"nous"|"vous"|"ils")
V ("suis"|"es"|"est"|"sommes"|"etes"|"sont"|"ai"|"as"|"a"|"avons"|"avez"|"ont"|"mange"|"manges"|"mangeons"|"mangez"|"mangent"|"bois"|"boit"|"buvons"|"buvez"|"boivent")
C ("eau"|"gateau"|"crepe"|"pomme")
Adj ("beau"|"delicieux"|"rouge"|"bleu"|"jaune"|"heureux")
ND ("ne"|"not")
NF ("pas")
T (?i:"hier"|"lundi"|"mardi"|"mercredi"|"jeudi"|"vendredi"|"samedi"|"dimanche"|"demain"|"hier"|"aujourd'hui")
P ("."|"!"|"?")
A (?i:"un"|"une"|"la"|"le"|"les"|"quelques"|"mon"|"ma"|"mes"|"ton"|"tes"|"ta"|"son"|"sa"|"ses"|"notre"|"nos"|"vos"|"votre")


%%

{S} {yylval.string=dictionnaireFrancaisAnglais(yytext);return sujet;}
{V} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return verbe;}
{Adj} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return adjectif;}
{ND} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return negationDebut;}
{NF} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return negationFin;}
{A}     {yylval.string=dictionnaireFrancaisAnglais(yytext);return article;}
{C} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return complement;}
{T} 	{yylval.string=dictionnaireFrancaisAnglais(yytext);return temporalite;}
[ \t]	{return blanc;}
\n 	{return sautLigne;}
{P} 	{yylval.car=yytext[0];return point;}
.	{printf("mot inconnu -%s-\n", yytext);yylval.car=yytext[0];return joker;}
"$$$" 	{return FIN;}
"debut\n" {return DEBUT;}

%%

int yywrap(void){
	return 1;
}

// Demain et demain seront égaux
int comparaisonSansMajuscule(char* str1, char* str2){
	if(strcmp(str1, str2)==0){
		return 0;
	}else{
		char* str = malloc(strlen(str2)*sizeof(char));
		strcpy(str, str1);		
		str[0] = tolower(str1[0]);
		return strcmp(str2, str);
	}
}

char* dictionnaireFrancaisAnglais(char* motFrancais){
	if(comparaisonSansMajuscule(motFrancais, "je")==0){
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
	}else if(comparaisonSansMajuscule(motFrancais, "es")==0 || comparaisonSansMajuscule(motFrancais, "sommes")==0 || comparaisonSansMajuscule(motFrancais, "etes")==0 || comparaisonSansMajuscule(motFrancais, "sont")==0){
		return "are";
	}else if(comparaisonSansMajuscule(motFrancais, "suis")==0){
		return "am";
	}else if(comparaisonSansMajuscule(motFrancais, "est")==0){
		return "is";
	}else if(comparaisonSansMajuscule(motFrancais, "ai")==0 || comparaisonSansMajuscule(motFrancais, "as")==0 || comparaisonSansMajuscule(motFrancais, "avons")==0 || comparaisonSansMajuscule(motFrancais, "avez")==0 || comparaisonSansMajuscule(motFrancais, "ont")==0){
		return "have";
	}else if(comparaisonSansMajuscule(motFrancais, "a")==0){
		return "has";
	}else if(comparaisonSansMajuscule(motFrancais, "mange")==0 || comparaisonSansMajuscule(motFrancais, "manges")==0 || comparaisonSansMajuscule(motFrancais, "mangeons")==0 || comparaisonSansMajuscule(motFrancais, "mangez")==0 || comparaisonSansMajuscule(motFrancais, "mangent")==0){
		return "eat";
	}else if(comparaisonSansMajuscule(motFrancais, "mange")==0){
		return "eats"; // ne sera jamais utilisé puisque la même condition est juste au dessus. Il faudrait connaitre le contexte (le sujet) pour traduire correctement.
	}else if(comparaisonSansMajuscule(motFrancais, "bois")==0 || comparaisonSansMajuscule(motFrancais, "buvons")==0 || comparaisonSansMajuscule(motFrancais, "buvez")==0 || comparaisonSansMajuscule(motFrancais, "boivent")==0){
		return "drink";
	}else if(comparaisonSansMajuscule(motFrancais, "boit")==0){
		return "drinks";
	}else if(comparaisonSansMajuscule(motFrancais, "eau")==0){
		return "water";
	}else if(comparaisonSansMajuscule(motFrancais, "gateau")==0){
		return "cake";
	}else if(comparaisonSansMajuscule(motFrancais, "crepe")==0){
		return "pancake";
	}else if(comparaisonSansMajuscule(motFrancais, "pomme")==0){
		return "apple";
	}else if(comparaisonSansMajuscule(motFrancais, "fleur")==0){
		return "flower";
	}else if(comparaisonSansMajuscule(motFrancais, "beau")==0){
		return "beautiful";
	}else if(comparaisonSansMajuscule(motFrancais, "delicieux")==0){
		return "delicious";
	}else if(comparaisonSansMajuscule(motFrancais, "rouge")==0){
		return "red";
	}else if(comparaisonSansMajuscule(motFrancais, "bleu")==0){
		return "blue";
	}else if(comparaisonSansMajuscule(motFrancais, "jaune")==0){
		return "yellow";
	}else if(comparaisonSansMajuscule(motFrancais, "heureux")==0){
		return "happy";
	}else if(comparaisonSansMajuscule(motFrancais, "delicieux")==0){
		return "delicious";
	}else if(comparaisonSansMajuscule(motFrancais, "ne")==0){
		return "not";
	}else if(comparaisonSansMajuscule(motFrancais, "hier")==0){
		return "yesterday";
	}else if(comparaisonSansMajuscule(motFrancais, "lundi")==0){
		return "monday";
	}else if(comparaisonSansMajuscule(motFrancais, "mardi")==0){
		return "tuesday";
	}else if(comparaisonSansMajuscule(motFrancais, "mercredi")==0){
		return "wednesday";
	}else if(comparaisonSansMajuscule(motFrancais, "jeudi")==0){
		return "thursday";
	}else if(comparaisonSansMajuscule(motFrancais, "vendredi")==0){
		return "friday";
	}else if(comparaisonSansMajuscule(motFrancais, "samedi")==0){
		return "saturday";
	}else if(comparaisonSansMajuscule(motFrancais, "dimanche")==0){
		return "sunday";
	}else if(comparaisonSansMajuscule(motFrancais, "demain")==0){
		return "tomorrow";
	}else if(comparaisonSansMajuscule(motFrancais, "hier")==0){
		return "yesterday";
	}else if(comparaisonSansMajuscule(motFrancais, "aujourd'hui")==0){
		return "today";
	}else if(comparaisonSansMajuscule(motFrancais, "ne")==0){
		return "not";
	}else if(comparaisonSansMajuscule(motFrancais, "un")==0){
		return "a";
	}else if(comparaisonSansMajuscule(motFrancais, "une")==0){
		return "a";
	}else if(comparaisonSansMajuscule(motFrancais, "le")==0){
		return "the";
	}else if(comparaisonSansMajuscule(motFrancais, "la")==0){
		return "the";
	}else if(comparaisonSansMajuscule(motFrancais, "des")==0){
		return "";
	}else if(comparaisonSansMajuscule(motFrancais, "quelques")==0){
		return "somme";
	}else if(comparaisonSansMajuscule(motFrancais, "mon")==0 || comparaisonSansMajuscule(motFrancais, "mes")==0 || comparaisonSansMajuscule(motFrancais, "ma")==0){
		return "my";
	}else if(comparaisonSansMajuscule(motFrancais, "son")==0 || comparaisonSansMajuscule(motFrancais, "ses")==0){
		return "his";
	}else if(comparaisonSansMajuscule(motFrancais, "sa")==0){
		return "here";
	}else if(comparaisonSansMajuscule(motFrancais, "notre")==0 || comparaisonSansMajuscule(motFrancais, "nos")==0){
		return "us";
	}else if(comparaisonSansMajuscule(motFrancais, "votre")==0 || comparaisonSansMajuscule(motFrancais, "vos")==0 || comparaisonSansMajuscule(motFrancais, "tes")==0 || comparaisonSansMajuscule(motFrancais, "ta")==0 ||comparaisonSansMajuscule(motFrancais, "ton")==0){
		return "your";
	}else{
		char* res = malloc((strlen(motFrancais)+1)*sizeof(char));
		strcpy(res, motFrancais); // il faut renvoyer une copie car si le motFrancais est modifié par la suite cela modifiera aussi res. (hors motFrancais peut etre yytext)
		return res;
	}
}

