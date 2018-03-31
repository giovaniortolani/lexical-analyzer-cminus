/********************************************************/
/* Trabalho 1 - Ling. de Prog. e Compiladores           */
/* Analisador léxico da linguagem C- (C-Minus)          */
/* Bernardo Simões Lage Gomes Duarte    8598861 Turma 2 */
/* Gabriel Luiz Ferraz Souto            8936993 Turma 1 */
/* Giovani Ortolani Barbosa             8936648 Turma 2 */
/* Renan Rodrigues                      9278132 Turma 2 */
/********************************************************/

%{

#include "globals.h"

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
.                   { fprintf(yyout, "%s ERRO\n", yytext); errors++;}

%%

void lexicalAnalyzer(FILE *source, FILE *output) 
{
    yyin = source;
    yyout = output;
    yylex();
}

