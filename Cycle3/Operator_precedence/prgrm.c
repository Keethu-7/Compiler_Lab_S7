#include <stdio.h>
#include <string.h>

#define MAX 50

char stack[MAX], input[MAX];
int top = -1;

/* Push symbol to stack */
void push(char c) {
    stack[++top] = c;
}

/* Pop top symbol */
void pop() {
    top--;
}

/* Display stack and remaining input */
void display(int i) {
    for (int k = 0; k <= top; k++)
        printf("%c", stack[k]);
    printf("\t");

    for (int k = i; k < strlen(input); k++)
        printf("%c", input[k]);
    printf("\t");
}

/* Symbols including $ */
char symbols[] = {'+', '-', '*', '/', 'i', '(', ')', '$'};

/* Operator precedence table
   Rows: stack top
   Cols: current input
   Relations: < shift, > reduce, = equal precedence, E error
*/
char prec[8][8] = {
    /*       +    -    *    /    i    (    )    $  */
    /* + */ {'>', '>', '<', '<', '<', '<', '>', '>'},
    /* - */ {'>', '>', '<', '<', '<', '<', '>', '>'},
    /* * */ {'>', '>', '>', '>', '<', '<', '>', '>'},
    /* / */ {'>', '>', '>', '>', '<', '<', '>', '>'},
    /* i */ {'>', '>', '>', '>', 'E', 'E', '>', '>'},
    /* ( */ {'<', '<', '<', '<', '<', '<', '=', 'E'},
    /* ) */ {'>', '>', '>', '>', 'E', 'E', '>', '>'},
    /* $ */ {'<', '<', '<', '<', '<', '<', 'E', '='}
};

/* Get index of symbol in precedence table */
int getIndex(char c) {
    for (int i = 0; i < 8; i++)
        if (symbols[i] == c)
            return i;
    return -1;
}

int main() {
    int i = 0;
    char action;

    printf("Enter the input string (end with $): ");
    scanf("%s", input);

    push('$');
    printf("\nStack\tInput\tAction\n");

    while (1) {
        display(i);
        int row = getIndex(stack[top]);
        int col = getIndex(input[i]);

        if (row == -1 || col == -1) {
            printf("Error (invalid symbol)\n");
            break;
        }

        if (input[i] == '$' && stack[top] == '$') {
            printf("Accept\n");
            break;
        }

        action = prec[row][col];

        if (action == '<' || action == '=') {
            printf("Shift\n");
            push(input[i]);
            i++;
        } 
        else if (action == '>') {
            printf("Reduce\n");
            pop(); // simple reduction
        } 
        else {
            printf("Error\n");
            break;
        }
    }

    return 0;
}
