sujet (je|tu|il|elle|on|nous|vous|ils|I|you|he|she|it|we|they)
verbe (etre|avoir|manger|boire|be|have|eat|drink)
complement (eau|gateau|crepe|pomme|fleur|water|pancake|cake|apple|flower)
nom (eau|gateau|crepe|pomme|fleur|water|pancake|cake|apple|flower)
adjectif (beau|délicieux|rouge|bleu|jaune|beautiful|delicious|red|blue|yellow)
negation_debut (ne)
negation_fin (pas|not)
temporalite (hier|lundi|mardi|mercredi|jeudi|vendredi|samedi|dimanche|yesterday|monday|tuesday|wednesday|thursday|friday|saturday|sunday)
blanc [ \t]+
%%

{blanc}?(je){blanc}? printf("I ");
{blanc}?(tu){blanc}? printf("you ");
{blanc}?(il){blanc}? printf("he ");
{blanc}?(elle){blanc}? printf("she ");
{blanc}?(on){blanc}? printf("one ");
{blanc}?(nous){blanc}? printf("we ");
{blanc}?(vous){blanc}? printf("you ");
{blanc}?(ils){blanc}? printf("they ");
{blanc}?(etre){blanc}? printf("be ");
{blanc}?(avoir){blanc}? printf("have ");
{blanc}?(manger){blanc}? printf("eat ");
{blanc}?(boire){blanc}? printf("drink ");
{blanc}?(eau){blanc}? printf("water ");
{blanc}?(gateau){blanc}? printf("cake ");
{blanc}?(crepe){blanc}? printf("pancake ");
{blanc}?(pomme){blanc}? printf("apple ");
{blanc}?(fleur){blanc}? printf("flower ");
{blanc}?(beau){blanc}? printf("beautiful ");
{blanc}?(délicieux){blanc}? printf("delicious ");
{blanc}?(rouge){blanc}? printf("red ");
{blanc}?(bleu){blanc}? printf("blue ");
{blanc}?(jaune){blanc}? printf("yellow ");
{blanc}?(ne){blanc}? printf("not ");
{blanc}?(pas){blanc}? printf("  ");
{blanc}?(hier){blanc}? printf("yesterday ");
{blanc}?(lundi){blanc}? printf("monday ");
{blanc}?(mardi){blanc}? printf("tuesday ");
{blanc}?(mercredi){blanc}? printf("wednesday ");
{blanc}?(jeudi){blanc}? printf("thursday ");
{blanc}?(vendredi){blanc}? printf("friday ");
{blanc}?(samedi){blanc}? printf("saturday ");
{blanc}?(dimanche){blanc}? printf("sunday ");



%%
