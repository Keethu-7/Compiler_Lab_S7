%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ASTNode {
    char *op;
    int value;
    struct ASTNode *left;
    struct ASTNode *right;
} ASTNode;

ASTNode* createNode(char* op, ASTNode* left, ASTNode* right);
ASTNode* createLeaf(int value);
void printAST(ASTNode* root, int level);

extern int yylex();
int yyerror(char *s);
%}

%union {
    int num;
    ASTNode* node;
}

%token <num> NUMBER
%type <node> expr

%left '+' '-'
%left '*' '/'
%left UMINUS

%%

input:
    expr '\n'  { printAST($1, 0); }
;

expr:
    NUMBER                { $$ = createLeaf($1); }
  | expr '+' expr         { $$ = createNode("+", $1, $3); }
  | expr '-' expr         { $$ = createNode("-", $1, $3); }
  | expr '*' expr         { $$ = createNode("*", $1, $3); }
  | expr '/' expr         { $$ = createNode("/", $1, $3); }
  | '-' expr %prec UMINUS { $$ = createNode("UMINUS", $2, NULL); }
  | '(' expr ')'          { $$ = $2; }
;

%%

int main() {
    printf("Enter an expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}

// AST Construction Functions

ASTNode* createNode(char* op, ASTNode* left, ASTNode* right) {
    ASTNode* newNode = (ASTNode*) malloc(sizeof(ASTNode));
    newNode->op = strdup(op);
    newNode->left = left;
    newNode->right = right;
    return newNode;
}

ASTNode* createLeaf(int value) {
    ASTNode* newNode = (ASTNode*) malloc(sizeof(ASTNode));
    newNode->op = strdup("NUM");
    newNode->value = value;
    newNode->left = newNode->right = NULL;
    return newNode;
}

// Print AST with indentation
void printAST(ASTNode* root, int level) {
    if (root == NULL) return;

    for (int i = 0; i < level; i++) printf("  ");
    if (strcmp(root->op, "NUM") == 0)
        printf("%s: %d\n", root->op, root->value);
    else
        printf("%s\n", root->op);

    printAST(root->left, level + 1);
    printAST(root->right, level + 1);
}
