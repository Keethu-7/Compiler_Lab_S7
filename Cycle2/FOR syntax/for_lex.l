%{
#include "y.tab.h"
%}

%%
"for"         { return FOR; }
"++"          { return INC; }
"--"          { return DEC; }
"=="          { return EQ; }
"<="          { return LE; }
">="          { return GE; }
"!="          { return NE; }

"="           { return '='; }
";"           { return ';'; }
"<"           { return '<'; }
">"           { return '>'; }
"("           { return '('; }
")"           { return ')'; }
"{"           { return '{'; }
"}"           { return '}'; }
"("           { return '('; }
")"           { return ')'; }
"+"           { return '+'; }
"-"           { return '-'; }

[0-9]+        { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*   { return ID; }

[ \t\n]       ;  // skip whitespace
.             { printf("Invalid character: %s\n", yytext); }
%%
