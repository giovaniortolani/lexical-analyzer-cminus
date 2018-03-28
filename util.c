/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "util.h"

/* Procedure printToken prints a token 
 * and its lexeme to the listing file
 */
void printToken( TokenType token, const char* tokenString )
{ switch (token)
  { case IF:
    case ELSE:
    case INT:
    case RETURN:
    case VOID:
    case WHILE:
    case INPUT:
    case OUTPUT:
      fprintf(listing,
         "reserved word: %s\n",tokenString);
      break;
    case SOMA: fprintf(listing,"+\n"); break;
    case SUB: fprintf(listing,"-\n"); break;
    case MUL: fprintf(listing,"*\n"); break;
    case DIV: fprintf(listing,"/\n"); break;
    case MENOR: fprintf(listing,"<\n"); break;
    case MEIGUAL: fprintf(listing,";<=\n"); break;
    case MAIOR: fprintf(listing,">\n"); break;
    case MAIGUAL: fprintf(listing,">=\n"); break;
    case IGUAL: fprintf(listing,"==\n"); break;
    case DIF: fprintf(listing,"!=\n"); break;
    case ATRIB: fprintf(listing,"=\n"); break;
    case PV: fprintf(listing,";\n"); break;
    case V: fprintf(listing,",\n"); break;
    case AP: fprintf(listing,"(\n"); break;
    case FP: fprintf(listing,")\n"); break;
    case ACO: fprintf(listing,"[\n"); break;
    case FCO: fprintf(listing,"]\n"); break;
    case ACH: fprintf(listing,"{\n"); break;
    case FCH: fprintf(listing,"}\n"); break;
    case NUM:
      fprintf(listing,
          "NUM, val= %s\n",tokenString);
      break;
    case ID:
      fprintf(listing,
          "ID, name= %s\n",tokenString);
      break;
    case ERROR:
      fprintf(listing,
          "ERROR: %s\n",tokenString);
      break;
    default: /* should never happen */
      fprintf(listing,"Unknown token: %d\n",token);
  }
}


/* Function copyString allocates and makes a new
 * copy of an existing string
 */
char * copyString(char * s)
{ int n;
  char * t;
  if (s==NULL) return NULL;
  n = strlen(s)+1;
  t = malloc(n);
  if (t==NULL)
    fprintf(listing,"Out of memory error at line %d\n",lineno);
  else strcpy(t,s);
  return t;
}

/* Variable indentno is used by printTree to
 * store current number of spaces to indent
 */
static indentno = 0;

/* macros to increase/decrease indentation */
#define INDENT indentno+=2
#define UNINDENT indentno-=2

/* printSpaces indents by printing spaces */
static void printSpaces(void)
{ int i;
  for (i=0;i<indentno;i++)
    fprintf(listing," ");
}


