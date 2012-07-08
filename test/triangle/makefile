#######################################################
# Change based on your system's configuration

DER2_PATH = /usr/local/src/Derelict3

#######################################################

DMD_BUILD_FLAGS 		= -gc -unittest

PROJECT_NAME 			= odesseytest
PROJECT_SRC				= src/*.d
PROJECT_BUILD_PATH		= build
PROJECT_IMPORT_FLAGS	= -Isrc

ODYSSEY_SRC_ROOT		= ../../src
ODYSSEY_SRC		 		= $(ODYSSEY_SRC_ROOT)/*/*.d
ODYSSEY_INCLUDE_FLAGS	= -I$(ODYSSEY_SRC_ROOT)

DER2_LINKER_FLAGS 		= -L-lDerelictUtil -L-lDerelictGL3 -L-lDerelictGLFW3

all:
	dmd $(DMD_BUILD_FLAGS) \
	$(PROJECT_SRC) $(ODYSSEY_SRC) \
	$(PROJECT_IMPORT_FLAGS) $(ODYSSEY_FLAGS) \
	-I$(DER2_PATH)/import \
	-L-L$(DER2_PATH)/lib \
	$(DER2_LINKER_FLAGS) \
	-od$(PROJECT_BUILD_PATH) -of$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)
	
run:
	@./$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)

br: all run
	
clean:
	rm -R build/*