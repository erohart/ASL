%{
void yyerror(char *s);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char* concatenationAvecEspace(char* str1, char* str2);
char* concatenation(char* str1, char* str2);
char* concatenationChar(char* str, char c);
char* concatenationChar2(char c, char* str);
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
%token <car> joker
%type <string> sujetVerbe

%%

phrase 	: DEBUT phrase		{
					printf("%s \n", trad);
					return 0;
				}
	| sujetVerbe point phrase	{
						char* etape1 = concatenationChar($1, $2);
						char* etape2 = concatenation(etape1, "\n");
						trad = concatenation(etape2, trad);
					}
	| sautLigne sujetVerbe point phrase	{
							char* etape1 = concatenationChar($2, $3);
							char* etape2 = concatenation(etape1, "\n");
							trad = concatenation(etape2, trad);
						}
	| joker phrase	{
				trad = concatenationChar2($1, trad);
			}
	| sautLigne FIN sautLigne 	{printf("La traduction est : \n");}
	;
sujetVerbe 	:temporalite blanc sujetVerbe 	{
							char* etape1 = concatenation($1, ",");
							$$ = concatenationAvecEspace(etape1, $3);
						}
		| sujet blanc verbe 	{
						$$ = concatenationAvecEspace($1, $3);
					}
		| sujet blanc verbe blanc article blanc complement	{
										char* etape1 = concatenationAvecEspace($1, $3);
										char* etape2 = concatenationAvecEspace(etape1, $5);
										$$ = concatenationAvecEspace(etape2, $7);
									}
		| sujet blanc verbe blanc adjectif	{
								char* etape1 = concatenationAvecEspace($1, $3);
								$$ = concatenationAvecEspace(etape1, $5);
							}
		| sujet blanc negationDebut blanc verbe blanc negationFin blanc adjectif 	{
													char* etape1 = concatenationAvecEspace($1, $5);
													char* etape2 = concatenationAvecEspace(etape1, $3);
													$$ = concatenationAvecEspace(etape2, $9);
												}
		| sujet blanc verbe blanc adjectif blanc temporalite	{
										char* etape1 = concatenation($7, ",");
										char* etape2 = concatenationAvecEspace(etape1, $1);
										char* etape3 = concatenationAvecEspace(etape2, $3);
										$$ = concatenation(etape3, $5);
									}
		| sujet blanc verbe blanc article blanc complement blanc adjectif	{
												char* etape1 = concatenationAvecEspace($1, $3);
												char* etape2 = concatenationAvecEspace(etape1, $9);
												char* etape3 = concatenationAvecEspace(etape2, $5);
												$$ = concatenationAvecEspace(etape3, $7);
											}
		| sujet blanc negationDebut blanc verbe blanc negationFin blanc article blanc complement blanc adjectif 	{
																	char* etape1 = concatenationAvecEspace($1, $5);
																	char* etape2 = concatenationAvecEspace(etape1, $3);
																	char* etape3 = concatenationAvecEspace(etape2, $13);
																	char* etape4 = concatenationAvecEspace(etape3, $9);
																	$$ = concatenationAvecEspace(etape4, $11);
																}
		| sujet blanc verbe blanc article blanc complement blanc adjectif blanc temporalite	{
														char* etape1 = concatenation($11, ",");
														char* etape2 = concatenationAvecEspace(etape2, $1);
														char* etape3 = concatenationAvecEspace(etape3, $3);
														char* etape4 = concatenationAvecEspace(etape3, $7);
														char* etape5 = concatenationAvecEspace(etape4, $5);
														$$ = concatenationAvecEspace(etape5, $9);
													}
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

char* concatenationChar2(char c, char* str){
	char strc[2];
	strc[0] = c;
	strc[1] = '\0';
	int l = strlen(str);
	char* res = malloc((l+1)*sizeof(char));
	strcpy(res, strc);
	strcat(res, str);
	return res;
}
