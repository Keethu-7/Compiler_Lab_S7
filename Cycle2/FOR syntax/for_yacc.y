%{
#include <stdio.h>
int yyerror(char *s);
int yylex();
%}

%token FOR ID NUMBER
%token INC DEC EQ LE GE NE

%%

stmt:
    FOR '(' expr ';' expr ';' expr ')' simple_stmt
    {
        printf("Valid for-loop syntax.\n");
    }
;

expr:
      ID '=' expr
    | ID
    | NUMBER
    | expr '+' expr
    | expr '-' expr
    | expr EQ expr
    | expr LE expr
    | expr GE expr
    | expr NE expr
    | expr '<' expr
    | expr '>' expr
    | ID INC
    | ID DEC
;

simple_stmt:
      ID '=' expr ';'
    | '{' stmt_list '}'
;

stmt_list:
      simple_stmt
    | stmt_list simple_stmt
;

%%

int main() {
    printf("Enter a for loop statement:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Syntax Error: %s\n", s);
    return 0;
}
