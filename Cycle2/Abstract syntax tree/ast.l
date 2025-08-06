%{
#include "y.tab.h"
%}

%%

[0-9]+     { yylval.num = atoi(yytext); return NUMBER; }
[+\-*/()]  { return yytext[0]; }
[ \t]      ;
\n         { return '\n'; }
.          { printf("Invalid character: %s\n", yytext); }

%%
