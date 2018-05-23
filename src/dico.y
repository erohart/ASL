%{
	void yyerror(char *s);
	#include <stdio.h>
	#include <stdlib.h>
	//char trad[] = "trad";
%}

%token Sujet
%token Verbe
%token Complement
%token Adjectif
%token NegationDebut
%token NegationFin
%token Temporalite

%%
expr : '\n' {printf("retour ligne\n");}
	| phrase '\n'	{/*printf("-->%s\n",trad);*/printf("expr\n");} 
	;
phrase: Sujet ' ' Verbe ' ' Complement	{/*trad = $1+$3+$5;*/printf("phrase 1\n");}
	| Sujet ' ' Verbe ' ' Complement ' ' Adjectif	{/*trad = $1+$3+$7+$5;*/printf("phrase 2\n");}
	| Sujet ' ' NegationDebut ' ' Verbe ' ' NegationFin ' ' Complement	{/*trad = $1+$5+$3+$9;*/printf("phrase 3\n");} 
	| Sujet ' ' Verbe ' ' Complement ' ' Temporalite	{/*trad = $7+$1+$3+$5;*/printf("phrase 4\n");}
	| Sujet ' ' Verbe 	{printf("phrase 5\n");}
	;

%%
#include "dico.l.c"
void yyerror(char *s){
	fprintf(stderr,"yyerror : %s\n", s);
}
int main(){
	if (yyparse() != 0){
		fprintf(stderr, "erreur de syntaxe");
	}
	return 1;
}
