/*
#################################################################
#                   CABECERA PARA USO DE COLORES                #
#   Modo de uso: String.                                        # 
#   Cuando se este trabajando con un string es posible llamar   #
#   a las constantes definidas para editar el color del ASCII   #
#   es importante que despues de cada llamado, se vuelva al     #
#   color original con "RESET_COLOR". Se deja una funcion de    #
#   prueba.                                                     #
#                                                               #   
#################################################################
#                           SIMBOLOS                            #
#       COLOR_T → texto         ||      COLOR_F → fondo         #
#################################################################
*/
#ifndef COLORS_H

#include <stdio.h>
#define COLORS_H

#ifdef WINDOWS

#define RESET_COLOR		""
#define NEGRO_T        	""
#define NEGRO_F        	""
#define ROJO_T     		""
#define ROJO_F     		""
#define VERDE_T        	""
#define VERDE_F        	""
#define AMARILLO_T 		""
#define AMARILLO_F  	""
#define AZUL_T     		""
#define AZUL_F      	""
#define MAGENTA_T  		""
#define MAGENTA_F  		""
#define CYAN_T     		""
#define CYAN_F     		""
#define BLANCO_T   		""
#define BLANCO_F   		""


#endif
#define RESET_COLOR		"\x1b[0m"
#define NEGRO_T        	"\x1b[30m"
#define NEGRO_F        	//"\x1b[40m"
#define ROJO_T     		"\x1b[31m"
#define ROJO_F     		"\x1b[41m"
#define VERDE_T        	"\x1b[32m"
#define VERDE_F        	"\x1b[42m"
#define AMARILLO_T 		"\x1b[33m"
#define AMARILLO_F  	"\x1b[43m"
#define AZUL_T     		"\x1b[34m"
#define AZUL_F      	"\x1b[44m"
#define MAGENTA_T  		"\x1b[35m"
#define MAGENTA_F  		"\x1b[45m"
#define CYAN_T     		"\x1b[36m"
#define CYAN_F     		"\x1b[46m"
#define BLANCO_T   		"\x1b[37m"
#define BLANCO_F   		"\x1b[47m"



// funcion para la prueba de los colores 

#define COLOR_TEST printf(ROJO_T "ROJO " AZUL_T " AZUL " AMARILLO_T VERDE_F " BRASIL " RESET_COLOR "\n")


#endif