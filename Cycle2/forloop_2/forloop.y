%{
#include <stdio.h>
void yyerror(const char *s);
int yylex();
%}

%token FOR ID NUMBER RELOP KEYWORD INC DEC INVALID
%start program

%%
program: for_statement   { printf("Valid FOR statement\n"); }
       ;

for_statement: FOR '(' initialization ';' condition ';' update ')' statement
             ;

initialization: expression
              | declaration
              ;

declaration: type ID '=' expression
           | type ID
           ;

type: ID
    ;

condition: expression
         | /* empty */
         ;

update: expression
      | /* empty */
      ;

expression: ID '=' expression
          | ID RELOP expression
          | ID '+' expression
          | ID '-' expression
          | ID '*' expression
          | ID '/' expression
          | ID INC
          | INC ID
          | ID DEC
          | DEC ID
          | NUMBER
          | ID
          ;

statement: simple_statement
         | compound_statement
         ;

simple_statement: expression ';'
                | ';'
                ;

compound_statement: '{' statement_list '}'
                  | '{' '}'
                  ;

statement_list: statement
              | statement_list statement
              ;
%%

void yyerror(const char *s) {
    printf("Syntax error: %s\n", s);
}

int main() {
    printf("Enter FOR statements:\n");
    yyparse();
    return 0;
}
