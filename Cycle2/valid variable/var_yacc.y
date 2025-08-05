%{
#include <stdio.h>
#include <stdlib.h>
%}

%token IDENTIFIER

%%
input:
      IDENTIFIER { printf("Valid variable name: %s\n", yytext); }
    | error      { printf("Invalid variable name\n"); yyerrok; }
    ;
%%

int main() {
    printf("Enter a variable name: ");
    yyparse();
    return 0;
}

int yyerror(char *msg) {
    return 0;
}
