# Makefile General (Windows 7|8|10 y Linux)

A continuación, se describe un Makefile General para el leguaje C. El propósito de este Makefile es la separación del código sin preocupación de estar compilando todo por separado.


#### Windows 10 o menor

Debido a que MS-DOS no puede cumplir con ciertas de las nuevas funcionalidades del Makefile, se decidio dejar de dar soporte a la version del Makefile.

[Version makefile windows 10 o menor](https://github.com/ngutierrezp/GeneralMakefile/tree/windows10-)


## Requisitos:

Es necesario para un correcto funcionamiento tener instalado `@make`. Para instalarlo hay que tener en cuenta que OS se posee:

---
##### Windows:

El paquete **Base** de [MinGW](http://www.mingw.org/) además de poseer diferentes compiladores, posee make de la forma: `mingw32-make`



##### Linux:

En este caso es más fácil y solo basta :
```linux
sudo apt install make
```

---
Cuando se tenga make como comando, es necesario saber que se dispondrán de las siguientes carpetas: 

src/ <- debe incluir todos los .c del código

obj/ <- debe incluir todos los .o resultantes de la compilación

incl/ <- deben estar todas las bibliotecas (.h) que utilizan los .c

## Comandos:

A continuación se detallan los comandos permitos por el Makefile.

--------------------


`$ make install`

Este comando inicia la estructura por defecto para utilizar el Makefile. Al usar el comando se crea en la carpeta de origen las siguientes 3 carpetas. 


```
├── root/
│   └── src/
|   |    └── main.c
|   |    └── example.c
|   └── obj/
|   └── incl/
|        └── example.h
|
```

Luego si utilizamos el comando, deberiamos obtener: 

```bash
Inicializando programa:

Generando carpetas contenedoras ...
[OK]
Generando Archivo example.c en carpetas ...
[OK]
Generando Archivo example.h en carpetas ...
[OK]
Generando Archivo main.c en carpetas ...
[OK]
```

luego si ejecutamos  `$ make ` generará un archivo ejecutable llamado *lab.out | lab.exe*, el que si ejecutamos:

```console
This is a example of a complete program in C :D
```

----------------

`$ make new [nombres ...]`

El comando `new` , crea los archivos `.c y .h` detallados en `nombres`. se crean tantos .c y .h linkeados con el mismo nombre. 

Por ejemplo :

`$ make new list queue io example`

Lo anterior genera 4 .c con los nombres dados *lista.c, queue.c, io.c, example.c* además de los correspondientes .h. 

Ahora si se pone :

`$ make new list`

da :


```console
Creando archivos en la carpeta: list

generando archivo list.c y list.h

[OK]
```

En las carpetas genera: 

en src/list.c :


```c
#include "../incl/list.h"
```

en incl/list.h


```c
 #ifndef LIST_H
 #define LIST_H



 #endif
```
--------------------
`make rm [nombres ....]`

El comando elimina todos los archivos .c y .h de las carpetas correspondientes donde encuentre **[nombres]**

Por ejemplo: 

`make rm test`

Eliminaria *test.c* y *test.h* de las carpetas.

En caso de no existir estos archivos, no de dará error, solo se dirá [OK]


--------------------------
`make clean`

Este comando elimina los archivos object (.o) de la carpeta obj/ ademas de los ejecutables resultantes de la compilación. 


--------------------------
`make with-clean`

Este comando antes de realizar la compilación de todos los .c y generar los ejecutables, ejecuta el comando `clean`, es decir, limpia los .o y los ejecutables.


--------------------------
`make debug`

Este comando compila en modo `DEBUG` . Este modo, define en el momento de compilación un valor `DEBUG`. 





