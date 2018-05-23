%{
void yyerror(char *s);
#include <stdio.h>
#include <string.h>
char* concatenationAvecEspace(char* str1, char* str2);
%}

%union {char* string; char car;}
%start phrase
%token blanc
%token point
%token <string> sujet
%token <string> verbe
%type <string> sujetVerbe

%%

phrase 	: sujetVerbe point 	{printf("yacc:phrase est : %s.\n", $1);}
	;
sujetVerbe 	: sujet blanc verbe 	{ printf("yacc:LaPhrase, sujet=%s_verbe=%s\n", $1, $3); $$ = concatenationAvecEspace($1, $3);}
		;
%%

int main(void){
	return yyparse();
}

void yyerror(char *s){
	fprintf(stderr, "yacc erreur : %s\n", s);
}

// concatene str1 et str2 en ajoutant un espace en les 2
char* concatenationAvecEspace(char* str1, char* str2){
	printf("$1 = %s\n", str1);
	printf("$3 = %s\n", str2);
	int l1 = 0;
	int l2 = 0;
	while(str1[l1]!='\0'){
		l1++;
	}
	while(str2[l2]!='\0'){
		l2++;
	}
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
