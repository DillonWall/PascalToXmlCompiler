##**************************************
## Makefile
##
## Build routine for pascal compiler
##
## Author: Phil Howard 
## phil.howard@oit.edu
##

COPTS=-Wall -g -c  -O0 -std=c++11
OBJS=main.o \
	 pascallex.o \
	 pascalparse.o \
	 cVisitor.o \
	 cSymbolTable.o \

all: pascal

clean:
	rm -f $(OBJS)
	rm -f pascallex.c
	rm -f pascalparse.c
	rm -f pascalparse.h
	rm -f pascal
	rm -f out.xml
	rm -f out2.xml
	rm -f out

.cpp.o:
	g++ $(COPTS) $? -o $@

.c.o:
	g++ $(COPTS) $? -o $@

main.o: main.cpp pascalparse.c pascallex.c 
	g++ $(COPTS) main.cpp -o $@

pascallex.o: pascallex.c
	g++ $(COPTS) -Wno-sign-compare $? -o $@

pascallex.c: pascal.l pascalparse.c
	flex -o pascallex.c pascal.l

pascalparse.c: pascal.y
	bison --defines=pascalparse.h pascal.y -o pascalparse.c

pascal: $(OBJS)
	g++ $(OBJS) -o pascal

