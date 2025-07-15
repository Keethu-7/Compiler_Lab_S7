#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int isKeyword(char buffer[]) {
    char keywords[32][10] = {"auto", "break", "case", "char", "const", "continue", "default",
                             "do", "double", "else", "enum", "extern", "float", "for", "goto",
                             "if", "int", "long", "register", "return", "short", "signed",
                             "sizeof", "static", "struct", "switch", "typedef", "union",
                             "unsigned", "void", "volatile", "while"};
    int i;
    for (i = 0; i < 32; ++i) {
        if (strcmp(keywords[i], buffer) == 0) {
            return 1;
        }
    }
    return 0;
}

int isParam(char c) {
    char param[100]="(){}[]";
    for(int i=0;i<6;i++) {
        if(param[i]==c) {
            return 1;
        }
    }
    return 0;
}

int isSepa(char c) {
    char sepa[100]=",;.";
    for(int i=0;i<3;i++) {
        if(sepa[i]==c) {
            return 1;
        }
    }
    return 0;
}

int isOper(char c) {
    char opera[100]="+-*/%=";
    for(int i=0;i<6;i++) {
        if(opera[i]==c) {
            return 1;
        }
    }
    return 0;
}

int main() {
    char c, buffer[100];
    FILE *fp;
    int i, j = 0,value;

    fp = fopen("Program.txt", "r");

    if (fp == NULL) {
        printf("Error while opening the file\n");
        exit(0);
    }

    while ((c = fgetc(fp)) != EOF) {
        if (isOper(c)) {
            printf("%c is an operator\n", c);
        }
        if (isSepa(c)) {
            printf("%c is a separator\n", c);
        }
        if (isParam(c)) {
            printf("%c is a parenthesis or brace\n", c);
        }
    
        if (isalnum(c)) {
            buffer[j++] = c;
        }
        else if ((c == ' ' || c == '\t' || c == '\n') && (j != 0)) {
            buffer[j] = '\0';
            j = 0;
    
            if (isKeyword(buffer))
                printf("The %s is a keyword\n", buffer);
            else
                printf("%s is an identifier\n", buffer);
        }
    }
    
    if (j != 0) {
        buffer[j] = '\0';
        if (isKeyword(buffer))
            printf("The %s is a keyword\n", buffer);
        else
            printf("%s is an identifier\n", buffer);
    }

    fclose(fp);
    return 0;
}
