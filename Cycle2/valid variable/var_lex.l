%{
#include "var_yacc.tab.h"
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*   { return IDENTIFIER; }
.|\n                    { return yytext[0]; }

%%
