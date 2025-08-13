/*%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct AST {
    char *op;
    struct AST *left;
    struct AST *right;
} AST;

AST* createNode(char *op, AST *left, AST *right);
AST* createLeaf(char *val);
void printAST(AST *node, int level);

int yylex();
int yyerror(char *s);
AST *root;  
%}

%union { char *str; struct AST *node; }

%token <str> NUMBER
%type <node> expr term factor

%left '+' '-'
%left '*' '/'

%%

expr: expr '+' term   { $$ = createNode("+", $1, $3); }
    | expr '-' term   { $$ = createNode("-", $1, $3); }
    | term            { $$ = $1; }
    ;

term: term '*' factor { $$ = createNode("*", $1, $3); }
    | term '/' factor { $$ = createNode("/", $1, $3); }
    | factor          { $$ = $1; }
    ;

factor: '(' expr ')'  { $$ = $2; }
      | NUMBER        { $$ = createLeaf($1); }
      ;

%%

AST* createNode(char *op, AST *left, AST *right) {
    AST *node = (AST*) malloc(sizeof(AST));
    node->op = strdup(op);
    node->left = left;
    node->right = right;
    return node;
}

AST* createLeaf(char *val) {
    return createNode(val, NULL, NULL);
}

void printAST(AST *node, int level) {
    if (!node) return;
    printAST(node->right, level + 1);
    for (int i = 0; i < level; i++) printf("   ");
    printf("%s\n", node->op);
    printAST(node->left, level + 1);
}

int yyerror(char *s) {
    printf("Syntax Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter expression: ");
    if (yyparse() == 0) {
        printf("\nAbstract Syntax Tree (Indented):\n");
        printAST(root, 0);
    }
    return 0;
}*/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

typedef struct node {
    struct node *left, *right;
    char val[20];
    int label;
} NODE;

NODE* makeNode(char *val, NODE* left, NODE* right) {
    NODE *temp = (NODE*) malloc(sizeof(NODE));
    strcpy(temp->val, val);
    temp->left = left;
    temp->right = right;
    temp->label = 0;
    return temp;
}

NODE* synTree;
%}

%union {
    char *str;
    struct node *node;
}

%token <str> PL MI MUL DIV OP CL EQ ID VAL SC UNR POW
%type <node> s e t f g

%left PL MI
%left MUL DIV
%right POW

%%

s : e { synTree = $1; }
  ;

e : e PL t { $$ = makeNode($2, $1, $3); }
  | e MI t { $$ = makeNode($2, $1, $3); }
  | t      { $$ = $1; }
  ;

t : t MUL f { $$ = makeNode($2, $1, $3); }
  | t DIV f { $$ = makeNode($2, $1, $3); }
  | f       { $$ = $1; }
  ;

f : g POW f { $$ = makeNode($2, $1, $3); }
  | g       { $$ = $1; }
  ;

g : OP e CL       { $$ = $2; }
  | ID            { $$ = makeNode($1, NULL, NULL); }
  | VAL           { $$ = makeNode($1, NULL, NULL); }
  ;

%%

void inOrder(NODE* root) {
    if (root) {
        inOrder(root->left);
        printf("%s ", root->val);
        inOrder(root->right);
    }
}

void preOrder(NODE* root) {
    if (root) {
        printf("%s ", root->val);
        preOrder(root->left);
        preOrder(root->right);
    }
}

void postOrder(NODE* root) {
    if (root) {
        postOrder(root->left);
        postOrder(root->right);
        printf("%s ", root->val);
    }
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter expression:\n");
    yyparse();

    printf("In Order:\n");
    inOrder(synTree);
    printf("\nPre Order:\n");
    preOrder(synTree);
    printf("\nPost Order:\n");
    postOrder(synTree);
    printf("\n");

    return 0;
}

