%{
void yyerror(char *s);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char* concatenationAvecEspace(char* str1, char* str2);
char* concatenation(char* str1, char* str2);
char* concatenationChar(char* str, char c);
char* retirerDernierCaractere(char* str);
char* trad = "";
%}

%union {char* string; char car;}
%start phrase
%token blanc
%token sautLigne
%token FIN
%token DEBUT
%token <car> point
%token <string> sujet
%token <string> verbe
%token <string> adjectif
%token <string> article
%token <string> complement
%token <string> negationDebut
%token <string> negationFin
%token <string> temporalite
%token <string> joker
%type <string> sujetVerbe

%%

phrase 	: DEBUT sujetVerbe point phrase	{
						char p = $3;
						char* etape1 = concatenationChar($2, p);
						char* etape2 = concatenation(etape1, "\n");
						char* etape3 = concatenation(etape2, trad);
						trad=concatenation(concatenation(concatenationChar($2, p),"\n"),trad);
						printf("%s \n", trad);
						return 0;
					}
	| sujetVerbe point phrase	{
						char p = $2;
						char* etape1 = concatenationChar($1, p);
						char* etape2 = concatenation(etape1, "\n");
						char* etape3 = concatenation(etape2, trad);
						trad=concatenation(concatenation(concatenationChar($1, p),"\n"),trad);
					}
	| sautLigne sujetVerbe point phrase	{
							char p = $3;
							char* etape1 = concatenationChar($2, p);
							char* etape2 = concatenation(etape1, "\n");
							char* etape3 = concatenation(etape2, trad);
							trad=concatenation(concatenation(concatenationChar($2, p),"\n"),trad);
						}
	//| sautLigne sautLigne	{printf("Fin : %s\n", trad);/*printf("fin\n");*/}// devrait permettre de pouvoir ecrire plusieures lignes mais ne fonctionne pas ...
	| sautLigne FIN sautLigne 	{printf("La traduction est : \n");}
	;
sujetVerbe 	: sujet blanc verbe 	{$$ = concatenationAvecEspace($1, $3);}
		| sujet blanc verbe blanc article blanc complement	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace($1, $3), $5), $7);}
		| sujet blanc verbe blanc adjectif	{$$ = concatenationAvecEspace(concatenationAvecEspace($1, $3), $5);}
		| sujet blanc negationDebut blanc verbe blanc negationFin blanc adjectif 	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace($1, $5), $3), $9);}
		| sujet blanc verbe blanc adjectif blanc temporalite	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenation($7, ","), $1), $3), $5);}
		| sujet blanc verbe blanc article blanc complement blanc adjectif	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace($1, $3), $9),$5),$7);}
		| sujet blanc negationDebut blanc verbe blanc negationFin blanc article blanc complement blanc adjectif 	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace($1, $5), $3), $13),$9),$11);}
		| sujet blanc verbe blanc article blanc complement blanc adjectif blanc temporalite	{$$ =concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenation($11, ","), $1), $3), $7),$5), $9);}
		;
%%

int main(void){
	printf("Ecrire \"debut\" puis appuyer sur enter pour commencer la traduction et ecrire \"$$$\" pour afficher la traduction.\n");
	return yyparse();
}

void yyerror(char *s){
	fprintf(stderr, "erreur : %s\n", s);
}

char* retirerDernierCaractere(char* str){
	int l = strlen(str);
	char* res = malloc((l-1)*sizeof(char));
	if(l>1){
		for(int i=0; i<l-1;i++){
			res[i] = str[i];
		}
		res[l-1] = '\0';
	}
	return res;
}

// concatene str1 et str2 en ajoutant un espace en les 2
char* concatenationAvecEspace(char* str1, char* str2){
	int l1 = strlen(str1);
	int l2 = strlen(str2);
/*
	{a,b,c,\0} => l1=3
	{d,e,\0} => l2=2
	{a,b,c, ,d,e,\0} => l=5=l1+l2+1
*/

	char* res = malloc((l1+l2+1)*sizeof(char));
	strcpy(res, str1);
	strcat(res, " ");
	strcat(res, str2);

	return res;
}

// concatene str1 et str2
char* concatenation(char* str1, char* str2){
	//printf("concatenation : -%s-%s- ==> ", str1, str2);
	int l1 = strlen(str1);
	int l2 = strlen(str2);
	char* res = malloc((l1+l2)*sizeof(char));
	strcpy(res, str1);
	strcat(res, str2);

	return res;
}

char* concatenationChar(char* str, char c){
	char strc[2];
	strc[0] = c;
	strc[1] = '\0';
	int l = strlen(str);
	char* res = malloc((l+1)*sizeof(char));
	strcpy(res, str);
	strcat(res, strc);
	return res;
}
