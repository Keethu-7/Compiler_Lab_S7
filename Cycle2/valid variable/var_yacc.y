%{
#include <stdio.h>
#include <stdlib.h>

extern char *yytext;
int yylex(void);
void yyerror(const char *s);
%}

%token IDENTIFIER

%%

input:
    /* empty */
    | input line
    ;

line:
      IDENTIFIER { printf("Valid variable name: %s\n", yytext); }
    | '\n'       { printf("Enter a variable name: "); }
    | error '\n' { printf("Invalid variable name\nEnter a variable name: "); yyerrok; }
    ;

%%

int main() {
    printf("Enter a variable name: ");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    // You can optionally print a syntax error here
}
