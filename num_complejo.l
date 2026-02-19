%{
#include <stdio.h>
#include <stdlib.h>
%}

/* ====== DEFINICIONES ====== */

/* Real con decimal y notación científica */
REAL    [+-]?(([0-9]+(\.[0-9]+)?)|(\.[0-9]+))([eE][+-]?[0-9]+)?

/* Unidad imaginaria */
IUNIT   [iIjJ]

/* Número complejo: a ± bi */
COMPLEJO   {REAL}[ \t]*[+-][ \t]*{REAL}{IUNIT}

%%

^{COMPLEJO}$     { printf("ACEPTA\n"); }
^.*$             { printf("NO ACEPTA\n"); }

%%

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error al abrir archivo");
        return 1;
    }

    yyin = file;
    yylex();

    fclose(file);
    return 0;
}
