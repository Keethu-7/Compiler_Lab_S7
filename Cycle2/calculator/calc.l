%{
#include "y.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[+\-*/()]   { return yytext[0]; }
[ \t\n]     ;   // skip whitespace
.           { printf("Invalid character: %s\n", yytext); }

%%
