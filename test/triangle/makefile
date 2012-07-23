#######################################################
# Change based on your system's configuration

DER2_IMPORTDIR = /usr/local/d
DER2_LIBDIR    = /usr/local/lib

#######################################################

D2 						= dmd

D2_BUILD_FLAGS 			= -g -property

PROJECT_NAME 			= triangle
PROJECT_SRC				= src/*.d
PROJECT_BUILD_PATH		= build
PROJECT_IMPORT_FLAGS	= -Isrc

ODYSSEY_SRC_ROOT		= ../../src
ODYSSEY_SRC		 		= $(ODYSSEY_SRC_ROOT)/*/*.d
ODYSSEY_INCLUDE_FLAGS	= -I$(ODYSSEY_SRC_ROOT)

DER2_LINKER_FLAGS 		= -L-lDerelictUtil -L-lDerelictGL3 -L-lDerelictGLFW3

all:
	$(D2) $(DMD_BUILD_FLAGS) \
	$(PROJECT_IMPORT_FLAGS) $(ODYSSEY_FLAGS) \
	-I/usr/local/src/Derelict3/import/ \
	-L-L/usr/local/src/Derelict3/lib/ \
	$(DER2_LINKER_FLAGS) \
	-od$(PROJECT_BUILD_PATH) -of$(PROJECT_BUILD_PATH)/$(PROJECT_NAME) \
	$(PROJECT_SRC) $(ODYSSEY_SRC)
	
run:
	@./$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)

br: all run
	
clean:
	rm -R build/*