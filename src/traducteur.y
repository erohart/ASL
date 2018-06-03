%{
void yyerror(char *s);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// Des fonctions permettant de concaténer les différents éléments des phrases pour en faire une phrase complète
char* concatenationAvecEspace(char* str1, char* str2);// concatène une chaine avec une autre en ajoutant un espace entre les deux
char* concatenation(char* str1, char* str2);// concatène les deux chaines
char* concatenationChar(char* str, char c);// concatène une chaine et un caractère
char* concatenationChar2(char c, char* str);// concatène un caractère et une chaine

char* trad = ""; // la chaine de caractère qui contiendra la traduction finale
%}
/* string et car sont les variables qui sont modifiées dans Lex avec yylval.string ou yylval.car */
/* Les token peuvent prendre string ou car comme type et contenir les mots identifiés et traduits par Lex */
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
%token <string> nom
%token <string> negationDebut
%token <string> negationFin
%token <string> temporalite
%token <car> joker
%type <string> sujetPredicat
%type <string> predicat

%%

phrase 	: DEBUT phrase		{
					printf("%s \n", trad);
					return 0;
				}
	| sujetPredicat point phrase	{
						char* str = concatenationChar($1, $2);
						str = concatenation(str, "\n");
						trad = concatenation(str, trad);
					}
	| sautLigne sujetPredicat point phrase	{
							char* str = concatenationChar($2, $3);
							str = concatenation(str, "\n");
							trad = concatenation(str, trad);
						}
	| joker phrase	{
				trad = concatenationChar2($1, trad);
			}

	| sautLigne FIN sautLigne 	{printf("La traduction est : \n");}
	;
sujetPredicat 	: sujet blanc predicat 	{
						$$ = concatenationAvecEspace($1, $3);
					}
		| sujet blanc verbe blanc adjectif blanc temporalite	{
										char* str = concatenation($7, ",");
										str = concatenationAvecEspace(str, $1);
										str = concatenationAvecEspace(str, $3);
										$$ = concatenationAvecEspace(str, $5);
									}
		| sujet blanc verbe blanc article blanc nom blanc adjectif blanc temporalite	{
														char* str = concatenation($11, ",");
														str = concatenationAvecEspace(str, $1);
														str = concatenationAvecEspace(str, $3);
														str = concatenationAvecEspace(str, $7);
														str = concatenationAvecEspace(str, $5);
														$$ = concatenationAvecEspace(str, $9);
													}
		| temporalite blanc sujetPredicat 	{
								char* str = concatenation($1, ",");
								$$ = concatenationAvecEspace(str, $3);
							}
		| article blanc nom blanc predicat 	{
								char* str = concatenationAvecEspace($1, $3);
								$$ = concatenationAvecEspace(str, $5);
							}
		;

predicat 	: verbe 	{
					$$ = $1;
				}
		| verbe blanc article blanc nom 	{
								char* str = concatenationAvecEspace($1, $3);
								$$ = concatenationAvecEspace(str, $5);
							}
		| verbe blanc adjectif 	{
						$$ = concatenationAvecEspace($1, $3);
					}
		| negationDebut blanc verbe blanc negationFin blanc adjectif 	{
											char* str = concatenationAvecEspace($3, $1);
											$$ = concatenationAvecEspace(str, $7);
										}
		| verbe blanc article blanc nom blanc adjectif 	{
										char* str = concatenationAvecEspace($1, $3);
										str = concatenationAvecEspace(str, $7);
										$$ = concatenationAvecEspace(str, $5);
									}
		| negationDebut blanc verbe blanc negationFin blanc article blanc nom blanc adjectif 	{
															char* str = concatenationAvecEspace($5, $3);
															str = concatenationAvecEspace(str, $7);
															str = concatenationAvecEspace(str, $11);
															$$ = concatenationAvecEspace(str, $9);
														}
		| negationDebut blanc verbe blanc negationFin blanc article blanc nom 	{
													char* str = concatenationAvecEspace($5, $3);
													str = concatenationAvecEspace(str, $7);
													$$ = concatenationAvecEspace(str, $9);
												}
		;
%%

int main(void){
	printf("Ecrire \"debut\" puis appuyer sur enter pour commencer la traduction et ecrire \"fin\" pour afficher la traduction.\n");
	return yyparse();
}

void yyerror(char *s){
	fprintf(stderr, "erreur : %s\n", s);
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
