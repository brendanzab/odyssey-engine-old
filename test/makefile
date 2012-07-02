#######################################################
# Change based on your system's configuration

DER2_PATH = /usr/local/src/Derelict3

#######################################################

DMD_BUILD_FLAGS 		= -gc

PROJECT_NAME 			= odesseytest
PROJECT_SRC				= src/*.d
PROJECT_BUILD_PATH		= build
PROJECT_IMPORT_FLAGS	= -Isrc

ODESSEY_SRC_ROOT		= ../src
ODESSEY_SRC		 		= $(ODESSEY_SRC_ROOT)/core/*.d  $(ODESSEY_SRC_ROOT)/math/*.d $(ODESSEY_SRC_ROOT)/render/*.d $(ODESSEY_SRC_ROOT)/util/*.d
ODESSEY_INCLUDE_FLAGS	= -I../../src

DER2_LINKER_FLAGS 		= -L-lDerelictUtil -L-lDerelictGL3 -L-lDerelictGLFW3

all:
	dmd $(DMD_BUILD_FLAGS) \
	$(PROJECT_SRC) $(ODESSEY_SRC) \
	$(PROJECT_IMPORT_FLAGS) $(ODESSEY_FLAGS) \
	-I$(DER2_PATH)/import \
	-L-L$(DER2_PATH)/lib \
	$(DER2_LINKER_FLAGS) \
	-od$(PROJECT_BUILD_PATH) -of$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)
	
run:
	@./$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)

br: all run