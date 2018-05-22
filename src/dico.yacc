%token Sujet
%token Verbe
%token Complement
%token Adjectif
%token NegationDebut
%token NegationFin
%token Temporalite

%{
	#include <stdio.h>
	char *trad;
%}

%%
expr : phrase '\n' {printf("-->%s\n",trad);} 
	|
	;

phrase: Sujet' 'Verbe' 'Complement {/*trad = $1+$3+$5;*/trad = "phrase 1";}
	| Sujet' 'Verbe' 'Complement' 'Adjectif {/*trad = $1+$3+$7+$5;*/trad = "phrase 2";}
	| Sujet' 'NegationDebut' 'Verbe' 'NegationFin' 'Complement {/*trad = $1+$5+$3+$9;*/trad = "phrase 3";} 
	| Sujet' 'Verbe' 'Complement' 'Temporalite     {/*trad = $7+$1+$3+$5;*/trad = "phrase 4";}
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
