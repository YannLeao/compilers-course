%option noyywrap noinput nounput nodefault

%{
#include "valida.tab.h"
%}

%%
"true"                          { return TRUE; }
"false"                         { return FALSE; }
"null"                          { return NULL_TOKEN; }

"{"                             { return '{'; }
"}"                             { return '}'; }
"["                             { return '['; }
"]"                             { return ']'; }
","                             { return ','; }
":"                             { return ':'; }

-?(0|[1-9][0-9]*)(\.[0-9]+)?    { return NUMBER; }
\"[^\"\n]*\"                  { return STRING; }

[ \t\n]+                      { }
.                               { return INVALID; }
%%
