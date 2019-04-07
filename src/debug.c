#include <stdio.h>
#include <string.h>
#include "../include/colors.h"
#include "../include/boards.h"
#include "../include/debug.h"


void print_current(matrix board,int current_ite, int current_lvl, int locals, int best_lvl, int best_locals){

    #ifdef LINUX
    printf(NEGRO_F VERDE_T"\t╔═══════════════════════════════════════════════════════════════════════╗\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t║     "AMARILLO_T"Contenido:                                                        "VERDE_T"║\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t╠═══════════════════════════════════════════════════════════════════════╣\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t║                                                                       ║\n"RESET_COLOR);
    printBoard(board);
    printf(NEGRO_F VERDE_T"\t║                                                                       ║\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t╠═══════════════════════════════════════════════════════════════════════╣\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t║    "NEGRO_F AMARILLO_T"Iteracion: "RESET_COLOR NEGRO_F"%i\t"VERDE_T"║\t"AMARILLO_T"Nivel : "RESET_COLOR NEGRO_F"%i\t"VERDE_T"║\t"AMARILLO_T"Sucursales: "RESET_COLOR NEGRO_F"%i\t"VERDE_T"║\n"RESET_COLOR,current_ite,current_lvl,locals);
    printf(NEGRO_F VERDE_T"\t╠═══════════════════════════════════════════════════════════════════════╣\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t║    "AMARILLO_T"Mejor Respuesta "ROJO_T"→ \t "AMARILLO_T"Nivel: "RESET_COLOR NEGRO_F"%i\t"VERDE_T"║\t"AMARILLO_T"Surcursales : "RESET_COLOR NEGRO_F"%i\t        "VERDE_T"║\n"RESET_COLOR,best_lvl,best_locals);
    printf(NEGRO_F VERDE_T"\t╚═══════════════════════════════════════════════════════════════════════╝\n"RESET_COLOR);
    #endif

    #ifdef WINDOWS
    printf(NEGRO_F VERDE_T"\t*-----------------------------------------------------------------------*\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t|     "AMARILLO_T"Contenido:                                                        "VERDE_T"|\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t*-----------------------------------------------------------------------*\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t|                                                                       |\n"RESET_COLOR);
    printBoard(board);
    printf(NEGRO_F VERDE_T"\t|                                                                       |\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t*-----------------------------------------------------------------------*\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t|    "NEGRO_F AMARILLO_T"Iteracion: "RESET_COLOR NEGRO_F"%i\t"VERDE_T"|\t"AMARILLO_T"Nivel : "RESET_COLOR NEGRO_F"%i\t"VERDE_T"|\t"AMARILLO_T"Sucursales: "RESET_COLOR NEGRO_F"%i\t"VERDE_T"|\n"RESET_COLOR,current_ite,current_lvl,locals);
    printf(NEGRO_F VERDE_T"\t*-----------------------------------------------------------------------*\n"RESET_COLOR);
    printf(NEGRO_F VERDE_T"\t|    "AMARILLO_T"Mejor Respuesta "ROJO_T"->\t "AMARILLO_T"Nivel: "RESET_COLOR NEGRO_F"%i\t"VERDE_T"|\t"AMARILLO_T"Surcursales : "RESET_COLOR NEGRO_F"%i\t        "VERDE_T"|\n"RESET_COLOR,best_lvl,best_locals);
    printf(NEGRO_F VERDE_T"\t*-----------------------------------------------------------------------*\n"RESET_COLOR);
    #endif

}

void printBoard(matrix current)
{
    int i,j,h=0;
    
    for(i = 0; i < current.high; i++)
    {
        #ifdef LINUX
        printf(NEGRO_F VERDE_T"\t║     ");
        #endif
        #ifdef WINDOWS
        printf(NEGRO_F VERDE_T"\t|     ");
        #endif
        for(j = 0; j < current.width; j++)
        {
            
            if(current.board[h]=='_'){
                printf(RESET_COLOR NEGRO_F"%c "RESET_COLOR NEGRO_F,current.board[h]);
            }
            else if (current.board[h]=='X') {
                printf(ROJO_T"%c "RESET_COLOR NEGRO_F,current.board[h]);
            }
            else
            {
                printf(RESET_COLOR"%c "RESET_COLOR NEGRO_F,current.board[h]);
            }
            h++;            

        }

        for(j = 0; j < 66-(current.width*2); j++)
        {
            printf(" ");
        }
        #ifdef LINUX
        printf( NEGRO_F VERDE_T"║\n"RESET_COLOR);
        #endif
        #ifdef WINDOWS
        printf( NEGRO_F VERDE_T"|\n"RESET_COLOR);
        #endif
        
        
    }
    
}
