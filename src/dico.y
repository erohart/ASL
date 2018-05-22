%token Sujet
%token Verbe
%token Complement
%token Adjectif
%token NegationDebut
%token NegationFin
%token Temporalite

%{
	#include <stdio.h>
	int yylex();
	char trad[] = "trad";
%}

%%
expr : '\n'
	|phrase '\n' {printf("-->%s\n",trad);} 
	|
	;

phrase: Sujet' 'Verbe' 'Complement {/*trad = $1+$3+$5;*/printf("phrase 1");}
	| Sujet' 'Verbe' 'Complement' 'Adjectif {/*trad = $1+$3+$7+$5;*/printf("phrase 2");}
	| Sujet' 'NegationDebut' 'Verbe' 'NegationFin' 'Complement {/*trad = $1+$5+$3+$9;*/printf("phrase 3");} 
	| Sujet' 'Verbe' 'Complement' 'Temporalite     {/*trad = $7+$1+$3+$5;*/printf("phrase 4");}
	;


%%
#include "dico.l.c"
yyerror() {printf(stderr,"erreur");}
int main(){
	if (yyparse() != 0){
		printf(stderr, "erreur de syntaxe");
	}
	return 1;
}
void fct(char* text){
	printf("=> %s", text);
}
