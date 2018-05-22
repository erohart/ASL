%token Sujet
%token Verbe
%token Complement
%token Adjectif
%token NegationDebut
%token NegationFin
%token Temporalite
%start S

%%
expr : '\n'
	| phrase '\n' {printf("-->%s\n",trad);} 

phrase: Sujet'+'Verbe'+'Complement {trad = $1+$3+$5;}
	| Sujet'+'Verbe'+'Complement'+'Adjectif {trad = $1+$3+$7+$5;}
	| Sujet'+'NegetionDebut'+'Verbe'+'NegationFin'+'Complement {trad = $1+$5+$3+$9;} 
	| Sujet'+'Verbe'+'Complement'+'Temporalite     {trad = $7+$1+$3+$5;}
	;


%%
#include <stdio.h>
#include "dico.lex.c"

yyerror() {printf(stderr,"erreur");}
int main() {if (yyparse() != 0){printf(stderr, "erreur de syntaxe"); return 1;}
