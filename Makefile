

#############################################################################
#				Parte 0: Definicion de variables    						#
#############################################################################

ARQUITECTURA = none
SISTEMA = none 
CODE_DIR= src
FIN_DIR = bin
INCL_DIR= include
CLEAN_COMMAND = none
COMPILE_COMMAND = gcc
EXECUTABLE_NAME = lab
OPTION_COMPILE = -D DEBUG
EXECUTABLE_NAME_DEBUG := $(EXECUTABLE_NAME)_debug



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
	CODE_DIR := $(CODE_DIR)\\
	INCL_DIR := $(INCL_DIR)\\
	FIN_DIR := $(FIN_DIR)\\
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
	CODE_DIR := $(CODE_DIR)/
	INCL_DIR := $(INCL_DIR)/
	FIN_DIR := $(FIN_DIR)/
	CLEAN_COMMAND := rm -f
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

all: $(EXECUTABLE_NAME)
	@echo $(SISTEMA) $(ARQUITECTURA) $(CODE_DIR) $(INCL_DIR) $(FIN_DIR)
	@echo "Compilacion terminada!!!!"
	@echo "Archivo generado : $(EXECUTABLE_NAME)"

$(EXECUTABLE_NAME): clean $(FIN_DIR)debug.o
	$(COMPILE_COMMAND) $(SISTEMA)  $(FIN_DIR)debug.o $(CODE_DIR)main.c -o $(EXECUTABLE_NAME)

$(FIN_DIR)debug.o: $(CODE_DIR)debug.c $(INCL_DIR)debug.h $(INCL_DIR)boards.h $(INCL_DIR)colors.h
	
	$(COMPILE_COMMAND) -c $(SISTEMA) $(CODE_DIR)debug.c -o $(FIN_DIR)debug.o

debug: $(EXECUTABLE_NAME_DEBUG)
	@echo "Programa compilado bajo la instruccion de debug"
	@echo "Archivo generado: $(EXECUTABLE_NAME_DEBUG)"

$(EXECUTABLE_NAME_DEBUG): clean $(FIN_DIR)debug_d.o 
	$(COMPILE_COMMAND) $(SISTEMA) $(OPTION_COMPILE) $(FIN_DIR)debug_d.o $(CODE_DIR)main.c -o $(EXECUTABLE_NAME_DEBUG) 

$(FIN_DIR)debug_d.o: $(CODE_DIR)debug.c $(INCL_DIR)debug.h $(INCL_DIR)boards.h $(INCL_DIR)colors.h
	$(COMPILE_COMMAND) -c $(SISTEMA) $(OPTION_COMPILE) $(CODE_DIR)debug.c -o $(FIN_DIR)debug_d.o

clean: 
	@echo "comando eliminar : $(CLEAN_COMMAND) $(FIN_DIR)*.o"
	$(CLEAN_COMMAND) $(FIN_DIR)*.o
	$(CLEAN_COMMAND) *.out *.exe
	@echo "Limpieza de archivos residuales completa!."