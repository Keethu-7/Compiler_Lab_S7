%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

char prefix[5]; // To store first four characters of the name
int initialized = 0;

%}

%%

[ \t\r]+              ;  // Ignore whitespace (space, tab, carriage return)

[\n]+                 ;  // Ignore empty newlines

[a-zA-Z0-9]+ {
    if (!initialized) {
        // First valid input is considered the name
        strncpy(prefix, yytext, 4);
        prefix[4] = '\0';
        printf("Stored prefix: %s\n", prefix);
        printf("Now enter words to check (type 'exit' to quit):\n");
        initialized = 1;
    } else {
        if (strcmp(yytext, "exit") == 0) {
            printf("Exiting...\n");
            exit(0);
        }
        if (strstr(yytext, prefix) == NULL) {
            printf("Accepted: %s\n", yytext);
        } else {
            printf("Rejected: %s\n", yytext);
        }
    }
}

[^a-zA-Z0-9 \t\r\n]+   {
    // Unexpected or special characters
    printf("Ignored special characters: %s\n", yytext);
}
%%

int main() {
    printf("Enter your name (first input): ");
    yylex();
    return 0;
}
