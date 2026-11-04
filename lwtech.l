%option noyywrap

%{
#include <stdio.h>
%}

%%

    /* requests */

"ASK LOC"$       { printf("Where are you?\n"); }

    /* location reports */

"AT BKS"$       { printf("I am at the bookstore.\n"); }
"AT LIB"$       { printf("I am at the library.\n"); }
"AT CAF"$       { printf("I am at the cafeteria.\n"); }
"AT FAO"$       { printf("I am at the Financial Aid Office.\n"); }
"AT W403"$      { printf("I am at room W403.\n"); }
"AT T221"$      { printf("I am at room T221.\n"); }

    /* navigation to landmarks */

"GTO BKS"$       { printf("Go to the bookstore.\n"); }
"GTO LIB"$       { printf("Go to the library.\n"); }
"GTO CAF"$       { printf("Go to the cafeteria.\n"); }
"GTO FAO"$       { printf("Go to the Financial Aid Office.\n"); }
"GTO W403"$      { printf("Go to room W403.\n"); }
"GTO T221"$      { printf("Go to room T221.\n"); }

    /* navigation directions */

"MOV NORTH "[1-9][0-9]*$ {
    printf("Move north %s steps.\n", yytext + 10);
}

"MOV SOUTH "[1-9][0-9]*$ {
    printf("Move south %s steps.\n", yytext + 10);
}

"MOV EAST "[1-9][0-9]*$ {
    printf("Move east %s steps.\n", yytext + 9);
}

"MOV WEST "[1-9][0-9]*$ {
    printf("Move west %s steps.\n", yytext + 9);
}

    /* acknowledgement messages */

"RCV"$          { printf("Message received.\n"); }
"ERR"$          { printf("Invalid message. Please resend.\n"); }

    /* invalid locations */

"AT "[A-Za-z0-9]+$ {
    printf("ERROR: Invalid location: %s\n", yytext + 3);
}

"GTO "[A-Za-z0-9]+$ {
    printf("ERROR: Invalid location: %s\n", yytext + 4);
}

    /* invalid directions */

"MOV "[A-Za-z]+" "[1-9][0-9]*$ {
    printf("ERROR: Invalid direction: %s\n", yytext + 4);
}

    /* invalid step counts */

"MOV NORTH "-?[0-9]+$ {
    printf("ERROR: Invalid number: %s\n", yytext + 10);
}

"MOV SOUTH "-?[0-9]+$ {
    printf("ERROR: Invalid number: %s\n", yytext + 10);
}

"MOV EAST "-?[0-9]+$ {
    printf("ERROR: Invalid number: %s\n", yytext + 9);
}

"MOV WEST "-?[0-9]+$ {
    printf("ERROR: Invalid number: %s\n", yytext + 9);
}

    /* invalid messages */

[^\n]+ {
    printf("ERROR: Invalid message: %s\n", yytext);
}

    /* to ignore new lines */

\n              { }

%%

int main() {
    printf("LWTech Campus Navigation Scanner\n");
    yylex();
    return 0;
}
