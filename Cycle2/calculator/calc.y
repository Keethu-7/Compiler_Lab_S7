%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%left UMINUS

%%

input:
      /* empty */
    | input expr '\n'   { printf("Result: %d\n", $2); }
    ;

expr:
      NUMBER            { $$ = $1; }
    | expr '+' expr     { $$ = $1 + $3; }
    | expr '-' expr     { $$ = $1 - $3; }
    | expr '*' expr     { $$ = $1 * $3; }
    | expr '/' expr     {
                          if ($3 == 0) {
                            printf("Error: Division by zero\n");
                            $$ = 0;
                          } else {
                            $$ = $1 / $3;
                          }
                        }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')'      { $$ = $2; }
    ;

%%

int main() {
    printf("Enter arithmetic expressions (Ctrl+C to exit):\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
