%{
void yyerror(char *s);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char* concatenationAvecEspace(char* str1, char* str2);
char* concatenation(char* str1, char* str2);
void retirerDernierCaractere(char* str);
char* trad = "";
char* trad1 = "";
char* trad2 = "";
char* tradf = "";
%}

%union {char* string; char car;}
%start phrase
%token blanc
%token sautLigne
%token FIN
%token DEBUT
%token <string> point
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

phrase 	: DEBUT sujetVerbe point phrase	{retirerDernierCaractere($3); trad=concatenation(concatenation(concatenation($2, $3),"\n"),trad);printf("%s \n", trad);}
	| sujetVerbe point phrase	{retirerDernierCaractere($2); trad=concatenation(concatenation(concatenation($1, $2),"\n"),trad);}
	| sautLigne sujetVerbe point phrase	{retirerDernierCaractere($3); trad=concatenation(concatenation(concatenation($2, $3),"\n"),trad); }
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

void retirerDernierCaractere(char* str){
	int l = strlen(str);
	str[l-2] = '\0';
}

// concatene str1 et str2 en ajoutant un espace en les 2
char* concatenationAvecEspace(char* str1, char* str2){
	int l1 = strlen(str1);
	int l2 = strlen(str2);
	char* res;
	if(l1!=0 && l2!=0){
		res = malloc((l1+l2+2)*sizeof(char));
		for(int k=0;k<l1;k++){
			res[k] = str1[k];
		}
		res[l1] = ' ';
		for(int k=0;k<l2;k++){
			res[k+l1+1] = str2[k];
		}
		res[l1+l2+2] = '\0';
	}else{
		res = malloc(2*sizeof(char));
		res[0] = ' ';
		res[1] = '\0';
	}
	return res;
}

// concatene str1 et str2
char* concatenation(char* str1, char* str2){
	int l1 = strlen(str1);
	int l2 = strlen(str2);
	char* res = malloc((l1+l2+1)*sizeof(char));
	for(int k=0;k<l1;k++){
		res[k] = str1[k];
	}
	for(int k=0;k<l2;k++){
		res[k+l1] = str2[k];
	}
	res[l1+l2+1] = '\0';
	return res;
}
