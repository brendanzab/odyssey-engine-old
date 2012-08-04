D2 			:= dmd
D2_FLAGS	:= -g -unittest -lib

NAME := odyssey
SOURCES := ./src/*/*.d
BUILDDIR := ./build

INCLUDE := -I/usr/local/include/d/
LIBRARY := -L-L/usr/local/lib  -L-lDerelictUtil -L-lDerelictGL3 -L-lDerelictGLFW3

all:
	mkdir -p $(BUILDDIR)
	$(D2) $(D2_FLAGS) \
	$(SOURCES) -od$(BUILDDIR) -of$(NAME) \
	$(INCLUDE) $(LIBRARY) \

clean:
	rm -R $(BUILDDIR)

# unittest: all
# 	dmd ./src/*/*/test/*.d