D2 			:= dmd
D2_FLAGS	:= -g -unittest -property

PROJECT_NAME := triangle
PROJECT_SOURCES	:= src/*.d
PROJECT_BUILD_PATH := build
PROJECT_INCLUDE	:= -Isrc

ODYSSEY_SOURCES := ../../src/*/*.d

INCLUDE := -I/usr/local/include/d/
LIBRARY := -L-L/usr/local/lib  -L-lDerelictUtil -L-lDerelictGL3 -L-lDerelictGLFW3

all:
	$(D2) $(D2_FLAGS) \
	$(PROJECT_SOURCES) $(ODYSSEY_SOURCES) \
	$(INCLUDE) $(LIBRARY) \
	$(PROJECT_INCLUDE) -od$(PROJECT_BUILD_PATH) -of$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)
	
run:
	@./$(PROJECT_BUILD_PATH)/$(PROJECT_NAME)

br: all run
	
clean:
	rm -R build/*