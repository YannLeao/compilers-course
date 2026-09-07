Respostas:

1. B
2. C
3. A
4. A
5. A
6. A
7. B

8. a.

REAL(3.14)
INT(3)
PONTO
PONTO
INT(5)
INT(42)

8. b.

Quando o scanner está no início de `3.`, a regra de números reais não casa,
pois exige ao menos um dígito depois do ponto. Duas regras casam apenas o
caractere `3`, ambas com comprimento 1:

```lex
[0-9]+    { printf("INT(%s)\n", yytext); }
.         { printf("ERRO(%s)\n", yytext); }
```

Como os casamentos possuem o mesmo comprimento, o Flex escolhe a regra escrita
primeiro, e por isso imprime `INT(3)`.

Depois de consumir o `3`, o scanner passa ao ponto. Nesse novo passo, estas
duas regras casam um caractere cada:

```lex
"."    { printf("PONTO\n"); }
.      { printf("ERRO(%s)\n", yytext); }
```

Novamente há empate, e a primeira regra vence, produzindo `PONTO`. A regra de
espaços em branco não participa de nenhuma dessas disputas; ela só casa quando
o scanner chega ao espaço seguinte.

8. c.

No ponto solto, as regras que casam são:

```lex
"."    { printf("PONTO\n"); }
.      { printf("ERRO(%s)\n", yytext); }
```

As duas reconhecem exatamente um caractere. A regra específica `"."` vence
porque aparece antes da regra genérica `.`. Sim, é o mesmo critério de
desempate usado na letra (b): quando dois casamentos têm o mesmo comprimento,
o Flex escolhe a regra que aparece primeiro no arquivo.

8. d.

Uma possível alteração é permitir zero ou mais dígitos dos dois lados do
ponto:

```lex
%option noyywrap
%{
#include <stdio.h>
%}
%%
"."              { printf("PONTO\n"); }
[0-9]*\.[0-9]*   { printf("REAL(%s)\n", yytext); }
[0-9]+           { printf("INT(%s)\n", yytext); }
[ \t\n]+         { }
.                 { printf("ERRO(%s)\n", yytext); }
%%
```

Para `3.` e `.5`, a regra de real reconhece dois caracteres, enquanto as
regras concorrentes reconhecem no máximo um. Ela vence pelo maior casamento,
independentemente de aparecer antes ou depois das regras de inteiro e de ponto.
Da mesma forma, `3.14` continua sendo reconhecido inteiro como `REAL(3.14)`.

Entretanto, `[0-9]*\.[0-9]*` também casa um ponto isolado, pois os dois grupos
de dígitos podem ter comprimento zero. Nesse caso, ela e a regra `"."`
reconhecem um caractere cada, e a ordem volta a ser decisiva. A regra `"."`
precisa aparecer antes da regra de real para que o ponto isolado continue
produzindo `PONTO`.

Uma alternativa mais restritiva, que não reconhece o ponto isolado como real,
é:

```lex
([0-9]+\.[0-9]*|\.[0-9]+)   { printf("REAL(%s)\n", yytext); }
```

Nessa versão, pelo menos um dos lados do ponto precisa conter dígitos. Assim,
`3.`, `.5` e `3.14` são reais, mas `.` só pode ser reconhecido pela regra
`"."` (ou pela regra genérica), eliminando a dependência entre a posição da
regra de real e a regra do ponto.
