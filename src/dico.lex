sujet [je,tu il,elle,on,nous,vous,ils,I,you,he,she,it,we,they]
verbe [etre,avoir,manger,boire,be,have,eat,drink]
complement [eau,gateau,crepe,pomme,fleur,water,pancake,cake,apple,flower]
nom [eau,gateau,crepe,pomme,fleur,water,pancake,cake,apple,flower]
adjectif [beau,délicieux,rouge,bleu,jaune,beautiful,delicious,red,blue,yellow]
negation_debut [ne]
negation_fin [pas,not]
temporalite [hier,lundi,mardi,mercredi,jeudi,vendredi,samedi,dimanche,monday,tuesday,wednesday,thursday,friday,saturday,sunday]

%%
{sujet}+{verbe} printf("une phrase");
{sujet}+{negation_debut}+{verbe}+{negation_fin} printf("phrase negative");
{sujet}+{verbe}+{temporalite} printf("temporel");
%%
