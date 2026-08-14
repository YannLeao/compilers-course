%{
int lines = 1;
int words = 0;
int integers = 0;
int floats = 0;
int punctuations = 0;
int chars = 0;
%}

%%

[a-zA-Z]+               { words++; chars += yyleng; }
[0-9]+\.[0-9]+          { floats++; chars += yyleng; }
[0-9]+                  { integers++; chars += yyleng; }
[.,;:!?]                { punctuations++; chars += yyleng; }
\n                      { lines++; chars += yyleng; }
.                       { chars += yyleng; }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    printf("lines: %d\n"
           "words: %d\n"
           "chars: %d\n"
           "integers: %d\n"
           "floats: %d\n"
           "punctuations: %d\n",
           lines, words, chars, integers, floats, punctuations);
    return 0;
}
