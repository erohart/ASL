%{
#include "y.tab.h"
%}

%%

"Je"	{printf("lex:sujet\n");yylval.string=yytext;return sujet;}
"suis"	{printf("lex:verbe\n");yylval.string=yytext;return verbe;}
[ \t]	{printf("lex:blanc\n");return blanc;}
"." 	{printf("lex:point\n");return point;}
.	{printf("lex:caractereInconnu\n");yyerror("lex-inconnu\n");return blanc;}

%%

int yywrap(void){
	return 1;
}
