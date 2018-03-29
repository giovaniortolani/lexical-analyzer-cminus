/****************************************************/
/* Trabalho 1 - Ling. de Prog. e Compiladores       */
/* Analisador léxico da linguagem C- (C-Minus)      */
/* Bernardo Simões Lage Gomes Duarte    8598861     */
/* Giovani Ortolani Barbosa             8936648     */
/* Renan Rodrigues                      9278132     */
/*                     Turma 2                      */
/****************************************************/

#include "globals.h"

int errors = 0;

int main(int argc, char **argv)
{ 
    char sourceFileName[50]; 
    char outputFileName[] = "relatorio.txt"; 
    //char tmpFileName[] = "tmp.txt"; 
    FILE *source; 
    FILE *output;
    //FILE *tmp;

    if(argc != 2)
    { 
        fprintf(stderr, "usage: %s <filename>\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    
    /******  VERIFICACAO, ABERTURA DO CODIGO-FONTE   ******/
    strcpy(sourceFileName, argv[1]) ;
    source = fopen(sourceFileName, "r");
    if(source == NULL)
    { 
        fprintf(stderr, "File %s not found\n", sourceFileName);
        exit(EXIT_FAILURE);
    }
    //yyin = source;
    /******************************************************/

    // /******  VERIFICACAO, ABERTURA DO RELATORIO TEMPORARIO  ******/
    // tmp = fopen(tmpFileName, "w+");
    // if(tmp == NULL)
    // {
    //     fprintf(stderr, "Could not open %s file\n", tmpFileName);
    //     exit(EXIT_FAILURE);
    // }
    // //yyout = tmp;
    // //yyout = stdout;
    // /************************************************************/
    
    //fprintf(stdout, "\nC- COMPILATION: %s\n", sourceFileName);

    /******  VERIFICACAO, ABERTURA DO RELATORIO DE SAIDA  ******/
    output = fopen(outputFileName, "w");
    if(output == NULL)
    {
        fprintf(stderr, "Could not open %s file\n", outputFileName);
        exit(EXIT_FAILURE);
    }
    //yyout = output;
    /************************************************************/

    lexicalAnalyzer(source, output);

    fprintf(output, "%d erros(s) encontrados(s)\n", errors);

    // Copia do tmp.txt para o relatorio.txt
    // rewind(tmp);
    // c = fgetc(tmp);
    // while(c != EOF)
    // {
    //     fputc(c, output);
    //     c = fgetc(tmp);
    // }

    fclose(source);
    //fclose(tmp);
    fclose(output);
    
    return 0;
}

