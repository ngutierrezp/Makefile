

#############################################################################
#				Parte 0: Definicion de variables    						#
#############################################################################

ARQUITECTURA = none
SISTEMA = none 
SRC= src
OBJ = obj
INCL_DIR= include
CLEAN_COMMAND = none
COMPILE_COMMAND = gcc
EXECUTABLE_NAME = lab
OPTION_COMPILE = -D DEBUG
ADD_EXTEN = none
EXECUTABLE_NAME_DEBUG := $(EXECUTABLE_NAME)_debug
## Solo colores
NO_COLOR= #\x1b[0m

OK_COLOR= #\x1b[32;01m

ERROR_COLOR= #\x1b[31;01m

WARN_COLOR= #\x1b[33;01m

SUSF_PRINT = #\e[1;34m

PUR_COLOR = #\033[0;35m






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
	SRC := $(SRC)\\
	INCL_DIR := $(INCL_DIR)\\
	OBJ := $(OBJ)\\
	ADD_EXTEN := 
	CLEAN_COMMAND := del
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
	SRC := $(SRC)/
	INCL_DIR := $(INCL_DIR)/
	OBJ := $(OBJ)/
	ADD_EXTEN := 
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

# Cada Makefile debe tener una sentencia "all" la cual compila todo como primera instruccion
#
#
#
#-------------------------------------------------------------------------
########################
# Sentencia de Recetas #
########################

SOURCES := $(wildcard $(SRC)*.c)
OBJECTS := $(patsubst $(SRC)%.c, $(OBJ)%.o, $(SOURCES))

all: clean main
	@echo "$(PUR_COLOR)Ejecutable generado!$(NO_COLOR) Nombre: $(OK_COLOR)$(EXECUTABLE_NAME)$(NO_COLOR) "


main: $(OBJECTS)
	@echo "Generando ejecutable ..."
	($(CC) $^ -lm $(DEBUG_MODE) $(SISTEMA) -o $(EXECUTABLE_NAME) && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; )
	@echo "\n"
	

debug: set-debug

set-debug: DEBUG_MODE := -DDEBUG
set-debug: all-debug

all-debug: clean main-debug
	@echo "$(ERROR_COLOR)[DEBUG MODE] $(PUR_COLOR)Ejecutable generado!$(NO_COLOR) Nombre: $(OK_COLOR)$(EXECUTABLE_NAME_DEBUG)$(NO_COLOR) "


main-debug: $(OBJECTS)
	@echo "Generando ejecutable ..."
	($(CC) $^ -lm $(DEBUG_MODE) $(SISTEMA) -o $(EXE_NAME_DEBUG) && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; )
	@echo "\n"

$(OBJ)%.o: $(SRC)%.c
	@echo "Generando archivos object de $@ ...."
	($(CC) $(DEBUG_MODE) $(SISTEMA) -lm -I$(SRC) -c $< -o $@ && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; )

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
	@echo >> $(OBJ)rm.o

	($(CLEAN_COMMAND) $(OBJ)*.o && echo "$(OK_COLOR)[OK]$(NO_COLOR)") \
		||  (echo "$(ERROR_COLOR)[ERROR]$(NO_COLOR)" && exit 1; ) 

	@echo "Limpieza de archivos residuales $(OK_COLOR)completa!!$(NO_COLOR)"
	@echo "$(PUR_COLOR)-------------------------------------------------------$(NO_COLOR)"

.SILENT: clean all make main $(OBJ)%.o $(SOURCES) $(OBJECTS) main-child $(SRC)%.c main-debug
