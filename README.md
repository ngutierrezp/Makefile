# Makefile General (Windows 7|8|10 y Linux)

A continuación, se describe un Makefile General para el leguaje C. El propósito de este Makefile es la separación del código sin preocupación de estar compilando todo por separado.


## Requisitos:

Es necesario para un correcto funcionamiento tener instalado `@make`. Para instalarlo hay que tener en cuenta que OS se posee:

---
##### Windows:

El paquete **Base** de [MinGW](http://www.mingw.org/) además de poseer diferentes compiladores, posee make de la forma: `mingw32-make`



##### Linux:

En este caso es más fácil y solo basta :
`sudo apt install make`

---
Cuando se tenga make como comando, es necesario saber que se dispondrán de las siguientes carpetas: 

src/ <- debe incluir todos los .c del código

obj/ <- debe incluir todos los .o resultantes de la compilación

incl/ <- deben estar todas las bibliotecas (.h) que utilizan los .c

## Comandos:

El Makefile, contiene un comando inicial con el que crea todas las carpetas contenedoras y genera un pequeño programa de ejemplo

`$ make init`

con esto el resultado deberia ser : 

>   Inicializando programa:
    Generando carpetas contenedoras ...
    [OK]
    Generando Archivo example.c en carpetas ...
    [OK]
    Generando Archivo example.h en carpetas ...
    [OK]
    Generando Archivo main.c en carpetas ...
    [OK]

luego si ejecutamos `$ make` generará un archivo ejecutable llamado *lab.out | lab.exe*, el que si ejecutamos:

> This is a example of a complete program in C :D

----------------

Además el Makefile posee el siguiente comando para crear nuevos archivos:

`$ make new [nombres]`

`$ make new list queue io example`

Lo anterior genera 4 .c con los nombres dados *lista.c, queue.c, io.c, example.c* además de los correspondientes .h. Por ejemplo :

`$ make new list`

da :

> Creando archivos en la carpeta: list
> generando archivo list.c y list.h
> [OK]

en src/list.c :

> #include "../incl/list.h"

en incl/list.h

> #ifndef LIST_H
> #define LIST_H
>
>
> #endif
