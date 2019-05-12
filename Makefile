#############################################################################
#							Makefile General 							   	#
#				Autor:		Nicolas Gutierrez								#
#				Fecha:			11/05/2019									#
#																			#
# Este programa tiene la finalidad de crear un ejecutable a partir de la   	#
# compilacion de diferentes archivos .c									   	#
# 																		   	#
# Para utlizarlo correctamente, los archivos deben estar separados de la   	#
# siguiente manera:															#
#																			#
# src/ <- debe incluir todos los .c del codigo								#
# obj/ <- debe incluir todos los .o resultantes de la compilción			#
# incl/ <- deben estar todas las librerias que utilizan los .c				#
#																			#
#############################################################################



#############################################################################
#				Parte 0: Definicion de variables    						#
#############################################################################

ARQUITECTURA = none
SISTEMA = none 
SRC= src
OBJ = obj
INCL_DIR= include
CLEAN_COMMAND = none
CC = gcc
EXECUTABLE_NAME = lab
OPTION_COMPILE = -D DEBUG
ADD_EXTEN = none
RM_OBJ := none
C_RM_OBJ := none
EXECUTABLE_NAME_DEBUG := $(EXECUTABLE_NAME)_debug


## Solo colores
NO_COLOR=

OK_COLOR= 

ERROR_COLOR= 

WARN_COLOR= 

SUSF_PRINT = 

PUR_COLOR = 






#############################################################################
#				Parte 1: Detectando Sistema Operativo						#
#############################################################################

# Detect operating system in Makefile.
# Author: He Tao
# Date: 2015-05-30

# Editado a preferencia por Nicolas Gutierrez

### WINDOWS ###
ifeq ($(OS),Windows_NT)
	SISTEMA = -D WINDOWS

	EXECUTABLE_NAME := $(EXECUTABLE_NAME).exe
	EXECUTABLE_NAME_DEBUG := $(EXECUTABLE_NAME_DEBUG).exe
	SRC := $(SRC)
	INCL_DIR := $(INCL_DIR)
	OBJ := $(OBJ)
	ADD_EXTEN :=\\
	CLEAN_COMMAND := rm
	C_RM_OBJ := $(OBJ)/rm.o
	RM_OBJ := $(OBJ)/*.o
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		# x64
		ARQUITECTURA = -D AMD64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		# x32
		ARQUITECTURA = -D IA32
	endif
else
#### PARA EL RESTO DE OS ####

	EXECUTABLE_NAME := $(EXECUTABLE_NAME).out
	EXECUTABLE_NAME_DEBUG := $(EXECUTABLE_NAME_DEBUG).out
	SRC := $(SRC)
	INCL_DIR := $(INCL_DIR)
	OBJ := $(OBJ)
	ADD_EXTEN :=/
	RM_OBJ := $(OBJ)/*.o
	C_RM_OBJ := $(OBJ)/rm.o
	CLEAN_COMMAND := rm -f

	NO_COLOR :=\033[0;0m

	OK_COLOR :=\033[0;32m

	ERROR_COLOR :=\033[0;31m

	WARN_COLOR :=\033[0;36m

	SUSF_PRINT :=\033[0;34m

	PUR_COLOR := \033[0;35m

	UNAME_S := $(shell uname -s)
	### LINUX ###
	ifeq ($(UNAME_S),Linux)
		SISTEMA := -D LINUX
	endif
	### MAC OS ###
	ifeq ($(UNAME_S),Darwin)
		SISTEMA := -D OSX
	endif
		UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		ARQUITECTURA := -D AMD64
	endif
		ifneq ($(filter %86,$(UNAME_P)),)
	ARQUITECTURA := -D IA32
		endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		SISTEMA := -D ARM
	endif
endif



#############################################################################
#				Parte 2: Sentencias de compilacion  						#
#############################################################################


########################
# Sentencia de Recetas #
########################

SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))

all: clean main
	@echo "$(PUR_COLOR)Ejecutable generado!$(NO_COLOR) Nombre: $(OK_COLOR)$(EXECUTABLE_NAME)$(NO_COLOR) "


main: $(OBJECTS)
	@echo "Generando ejecutable ..."
	($(CC) $^ -lm $(DEBUG_MODE) $(SISTEMA)  -o $(EXECUTABLE_NAME) && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; )
	@echo "\n"
	
$(OBJ)/%.o: $(SRC)/%.c
	@echo "Generando archivos object de $@ ...."
	($(CC) $(DEBUG_MODE) $(SISTEMA)  -lm -I$(SRC) -c $< -o $@ && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; )

debug: set-debug

set-debug: DEBUG_MODE := -DDEBUG
set-debug: all-debug

all-debug: clean main-debug
	@echo "$(ERROR_COLOR)[DEBUG MODE] $(PUR_COLOR)Ejecutable generado!$(NO_COLOR) Nombre: $(OK_COLOR)$(EXECUTABLE_NAME_DEBUG)$(NO_COLOR) "


main-debug: $(OBJECTS)
	@echo "Generando ejecutable ..."
	($(CC) $^ -lm $(DEBUG_MODE) $(SISTEMA) -o $(EXECUTABLE_NAME_DEBUG) && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; )
	@echo "\n"

clean:
	
	@echo "Eliminado $(WARN_COLOR).out$(NO_COLOR) antiguo..."
	@echo >> rm.out


	($(CLEAN_COMMAND) *.out && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; ) 


	@echo "Eliminado $(WARN_COLOR).exe$(NO_COLOR) antiguo..."
	@echo >> rm.exe


	($(CLEAN_COMMAND) *.exe && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; ) 



	@echo "Eliminado $(WARN_COLOR).o$(NO_COLOR) desactualizados..."
	@echo >> $(C_RM_OBJ)

	
	($(CLEAN_COMMAND) $(RM_OBJ) && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; ) 

	@echo "Limpieza de archivos residuales $(OK_COLOR)completa!!$(NO_COLOR)"
	@echo "$(PUR_COLOR)-------------------------------------------------------$(NO_COLOR)"

.SILENT: clean all make main $(OBJ)/%.o $(SOURCES) $(OBJECTS) main-child $(SRC)/%.c main-debug
