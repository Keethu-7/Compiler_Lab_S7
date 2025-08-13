%{
#include "y.tab.h"
#include <string.h>
%}

%%
"for"           { return FOR; }
"if"|"else"|"while"|"do"|"return"  { return KEYWORD; }
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }
[0-9]+          { return NUMBER; }
"=="|"!="|"<"|">"|"<="|">="  { return RELOP; }
"="             { return '='; }
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"++"            { return INC; }
"--"            { return DEC; }
"{"             { return '{'; }
"}"             { return '}'; }
"("             { return '('; }
")"             { return ')'; }
";"             { return ';'; }
[ \t\n]         { /* ignore whitespace */ }
.               { return INVALID; }
%%

int yywrap() { return 1; }
