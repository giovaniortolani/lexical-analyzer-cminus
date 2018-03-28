/****************************************************/
/* Trabalho 1 - Ling. de Prog. e Compiladores       */
/* Analisador léxico da linguagem C- (C-Minus)      */
/* Bernardo XXXXXXXXXXXXX                           */
/* Giovani Ortolani Barbosa     8936648             */
/* Renan  XXXXXXXXXXXXX                             */
/*                     Turma 2                      */
/****************************************************/

%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

/* provavelmente nao iremos usar isso aqui */
#include "globals.h"
#include "util.h"
#include "scan.h"

/* lexeme of indentifier or reserved word */
#define MAXTOKENLEN 40
char tokenString[MAXTOKENLEN+1];

FILE *source;
FILE *output;

int erros = 0;

%}

digito          [0-9]
numero          {digito}+
letra           [a-zA-Z]
identificador   {letra}+     
espacobranco    [ \n\t]+

%%

"if"                { fprintf(yyout, "%s Palavra-chave\n", yytext); }
"else"              { fprintf(yyout, "%s Palavra-chave\n", yytext); }
"int"               { fprintf(yyout, "%s Palavra-chave\n", yytext); }
"return"            { fprintf(yyout, "%s Palavra-chave\n", yytext); }
"void"              { fprintf(yyout, "%s Palavra-chave\n", yytext); }
"while"             { fprintf(yyout, "%s Palavra-chave\n", yytext); }
"+"                 { fprintf(yyout, "%s SOMA\n", yytext); }
"-"                 { fprintf(yyout, "%s SUB\n", yytext); }
"*"                 { fprintf(yyout, "%s MUL\n", yytext); }
"/"                 { fprintf(yyout, "%s DIV\n", yytext); }
"<"                 { fprintf(yyout, "%s MENOR\n", yytext); }
"<="                { fprintf(yyout, "%s MEIGUAL\n", yytext); }
">"                 { fprintf(yyout, "%s MAIOR\n", yytext); }
">="                { fprintf(yyout, "%s MAIGUAL\n", yytext); }
"=="                { fprintf(yyout, "%s IGUAL\n", yytext); }
"!="                { fprintf(yyout, "%s DIF\n", yytext); }
"="                 { fprintf(yyout, "%s ATRIB\n", yytext); }
";"                 { fprintf(yyout, "%s PV\n", yytext); }
","                 { fprintf(yyout, "%s V\n", yytext); }
"("                 { fprintf(yyout, "%s AP\n", yytext); }
")"                 { fprintf(yyout, "%s FP\n", yytext); }
"["                 { fprintf(yyout, "%s ACO\n", yytext); }
"]"                 { fprintf(yyout, "%s FCO\n", yytext); }  
"{"                 { fprintf(yyout, "%s ACH\n", yytext); }
"}"                 { fprintf(yyout, "%s FCH\n", yytext); }
{numero}            { fprintf(yyout, "%s NUM\n", yytext); }
{identificador}     { fprintf(yyout, "%s ID\n", yytext); }
{espacobranco}      { /* espaco em branco */ }
"/*"                { /* comentario */
                        char c;
                        int ok = FALSE;
                        do {
                            while ((c = input()) != '*');
                            while ((c = input()) == '*');
                            if (c == '/')
                                ok = TRUE;
                        } while(!ok);
                    }
.                   { fprintf(yyout, "%s ERRO\n", yytext); erros++;}

%%

int main(int argc, char **argv) {
    
    char sourceFileName[120]; /* source code file name */
    char outputFileName[] = "relatorio.txt"; 
    char tmpFileName[] = "tmp.txt"; 
    FILE *tmp;
    char c;

    if(argc != 2)
    { 
        fprintf(stderr, "usage: %s <filename>\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    
    /******  VERIFICACAO, ABERTURA DO CODIGO-FONTE   ******/
    strcpy(sourceFileName, argv[1]) ;
    if(strchr(sourceFileName, '.') == NULL)
    {
        strcat(sourceFileName, ".c-");
    }
    source = fopen(sourceFileName, "r");
    if(source == NULL)
    { 
        fprintf(stderr, "File %s not found\n", sourceFileName);
        exit(EXIT_FAILURE);
    }
    yyin = source;
        /******************************************************/

    /******  VERIFICACAO, ABERTURA DO RELATORIO TEMPORARIO  ******/
    tmp = fopen(tmpFileName, "w+");
    if(tmp == NULL)
    {
        fprintf(stderr, "Could not open %s file\n", tmpFileName);
        exit(EXIT_FAILURE);
    }
    yyout = tmp;
    //yyout = stdout;
    /************************************************************/
    
    //fprintf(stdout, "\nC- COMPILATION: %s\n", sourceFileName);

    yylex();

    output = fopen(outputFileName, "w");
    if(output == NULL)
    {
        fprintf(stderr, "Could not open %s file\n", outputFileName);
        exit(EXIT_FAILURE);
    }
    yyout = output;
    fprintf(yyout, "%d erros(s) encontrados(s)\n", erros);
    // Copia do tmp.txt para o relatorio.txt
    rewind(tmp);
    c = fgetc(tmp);
    while(c != EOF)
    {
        fputc(c, output);
        c = fgetc(tmp);
    }

    fclose(source);
    fclose(tmp);
    fclose(output);
    
    return 0;
}

