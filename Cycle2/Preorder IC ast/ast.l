/*%{
#include "y.tab.h"
%}

%%
[0-9]+      { yylval.str = strdup(yytext); return NUMBER; }
[ \t\n]     ;
.           { return yytext[0]; }
%%

int yywrap() { return 1; }
*/
%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

[0-9]+              { yylval.str = strdup(yytext); return VAL; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }

"+"                 { yylval.str = strdup(yytext); return PL; }
"-"                 { yylval.str = strdup(yytext); return MI; }
"*"                 { yylval.str = strdup(yytext); return MUL; }
"/"                 { yylval.str = strdup(yytext); return DIV; }
"^"                 { yylval.str = strdup(yytext); return POW; }
"("                 { return OP; }
")"                 { return CL; }

[ \t\n]             ; // Ignore whitespace

.                   { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
