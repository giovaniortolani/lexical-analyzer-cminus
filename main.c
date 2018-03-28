/****************************************************/
/* File: main.c                                     */
/* Main program for TINY compiler                   */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "scan.h"

/* allocate global variables */
int lineno = 0;
FILE * source;
FILE * listing;
FILE * code;

/* allocate and set tracing flags */
int EchoSource = TRUE;
int TraceScan = TRUE;
int TraceParse = FALSE;
int TraceAnalyze = FALSE;
int TraceCode = FALSE;

int Error = FALSE;

int main(int argc, char **argv)
{ 
    char pgm[120]; /* source code file name */
    if(argc != 2)
    { 
        fprintf(stderr, "usage: %s <filename>\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    strcpy(pgm, argv[1]) ;
    if(strchr(pgm, '.') == NULL)
    strcat(pgm, ".c-");
    source = fopen(pgm, "r");
    if(source == NULL)
    { 
        fprintf(stderr, "File %s not found\n", pgm);
        exit(1);
    }
    listing = stdout; /* send listing to screen */
    fprintf(listing, "\nC- COMPILATION: %s\n", pgm);

    while(getToken() != ENDFILE);

    fclose(source);

    return 0;
}

