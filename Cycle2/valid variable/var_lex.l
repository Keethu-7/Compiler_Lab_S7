%{
#include "y.tab.h"
%}

%%

[a-zA-Z][a-zA-Z0-9]*    { return IDENTIFIER; }
.|\n                    { return yytext[0]; }

%%
