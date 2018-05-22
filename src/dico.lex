sujet (je|tu|il|elle|on|nous|vous|ils|I|you|he|she|it|we|they)
verbe (etre|avoir|manger|boire|be|have|eat|drink)
complement (eau|gateau|crepe|pomme|fleur|water|pancake|cake|apple|flower)
adjectif (beau|délicieux|rouge|bleu|jaune|beautiful|delicious|red|blue|yellow)
negation_debut (ne|not)
negation_fin (pas)
temporalite (hier|lundi|mardi|mercredi|jeudi|vendredi|samedi|dimanche|yesterday|monday|tuesday|wednesday|thursday|friday|saturday|sunday)
blanc [ \t]+
%%

{blanc}?(je){blanc}? {printf("I ");fct(yytext);return Sujet;}
{blanc}?(tu){blanc}? {printf("you "); return Sujet;}
{blanc}?(il){blanc}? {printf("he "); return Sujet;}
{blanc}?(elle){blanc}? {printf("she "); return Sujet;}
{blanc}?(on){blanc}? {printf("one "); return Sujet;}
{blanc}?(nous){blanc}? {printf("we "); return Sujet;}
{blanc}?(vous){blanc}? {printf("you "); return Sujet;}
{blanc}?(ils){blanc}? {printf("they "); return Sujet;}
{blanc}?(etre){blanc}? {printf("be "); return Verbe;}
{blanc}?(avoir){blanc}? {printf("have "); return Verbe;}
{blanc}?(manger){blanc}? {printf("eat "); return Verbe;}
{blanc}?(boire){blanc}? {printf("drink "); return Verbe;}
{blanc}?(eau){blanc}? {printf("water "); return Complement;}
{blanc}?(gateau){blanc}? {printf("cake "); return Complement;}
{blanc}?(crepe){blanc}? {printf("pancake "); return Complement;}
{blanc}?(pomme){blanc}? {printf("apple "); return Complement;}
{blanc}?(fleur){blanc}? {printf("flower "); return Complement;}
{blanc}?(beau){blanc}? {printf("beautiful "); return Adjectif;}
{blanc}?(délicieux){blanc}? {printf("delicious "); return Adjectif;}
{blanc}?(rouge){blanc}? {printf("red "); return Adjectif;}
{blanc}?(bleu){blanc}? {printf("blue "); return Adjectif;}
{blanc}?(jaune){blanc}? {printf("yellow "); return Adjectif;}
{blanc}?(ne){blanc}? {printf("not "); return NegationDebut;}
{blanc}?(pas){blanc}? {printf("  "); return NegationFin;}
{blanc}?(hier){blanc}? {printf("yesterday "); return Temporalite;}
{blanc}?(lundi){blanc}? {printf("monday "); return Temporalite;}
{blanc}?(mardi){blanc}? {printf("tuesday "); return Temporalite;}
{blanc}?(mercredi){blanc}? {printf("wednesday "); return Temporalite;}
{blanc}?(jeudi){blanc}? {printf("thursday "); return Temporalite;}
{blanc}?(vendredi){blanc}? {printf("friday "); return Temporalite;}
{blanc}?(samedi){blanc}? {printf("saturday "); return Temporalite;}
{blanc}?(dimanche){blanc}? {printf("sunday "); return Temporalite;}
\n {return ('\n');}

%%

