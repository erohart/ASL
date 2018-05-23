%{
void yyerror(char *s);
#include <stdio.h>
#include <string.h>
char* concatenationAvecEspace(char* str1, char* str2);
char* concatenation(char* str1, char* str2);
%}

%union {char* string; char car;}
%start phrase
%token blanc
%token point
%token sautLigne
%token <string> sujet
%token <string> verbe
%token <string> adjectif
%token <string> complement
%token <string> negationDebut
%token <string> negationFin
%token <string> temporalite
%type <string> sujetVerbe

%%

phrase 	: sujetVerbe point	{printf("%s.\n", $1);}
	;
sujetVerbe 	: sujet blanc verbe 	{$$ = concatenationAvecEspace($1, $3);}
		| sujet blanc verbe blanc complement	{$$ = concatenationAvecEspace(concatenationAvecEspace($1, $3), $5);}
		| sujet blanc verbe blanc adjectif	{$$ = concatenationAvecEspace(concatenationAvecEspace($1, $3), $5);}
		| sujet blanc negationDebut blanc verbe blanc negationFin blanc adjectif 	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace($1, $5), $3), $9);}
		| sujet blanc verbe blanc adjectif blanc temporalite	{$$ = concatenationAvecEspace(concatenationAvecEspace(concatenationAvecEspace(concatenation($7, ","), $1), $3), $5);}
		;
%%

int main(void){
	return yyparse();
}

void yyerror(char *s){
	fprintf(stderr, "erreur : %s\n", s);
}

// concatene str1 et str2 en ajoutant un espace en les 2
char* concatenationAvecEspace(char* str1, char* str2){
	int l1 = strlen(str1);
	int l2 = strlen(str2);
	char* res = malloc((l1+l2+2)*sizeof(char));
	for(int k=0;k<l1;k++){
		res[k] = str1[k];
	}
	res[l1] = ' ';
	for(int k=0;k<l2;k++){
		res[k+l1+1] = str2[k];
	}
	res[l1+l2+2] = '\0';
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
