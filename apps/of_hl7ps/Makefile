# Makefile for apps/of_hl7ps

include $(MESA_MAKE)

CXX_FLAGS = $(C_OPTS)

BIN = of_hl7ps
FILES = \
        MLMessenger
#        MAMessenger
OBJS = $(BIN:=.o) $(FILES:=.o)

L_FLAGS = $(L_OPTS)


$(BIN): $(OBJS)
	$(CXX) -o $@ $(OBJS) $(L_FLAGS) $(LIBS_MESA) $(LIBS_ACE)

install:	$(BIN)
	$(INSTALL) $(BIN) $(MESA_BIN)

relink:
	$(CXX) -o $(BIN) $(OBJS) $(L_FLAGS) $(LIBS_MESA) $(LIBS_ACE)

clean:
	rm -rf *.o *~ *.bak *.rpo core $(BIN)

run:
	./of_hl7ps -l 3 2200

analysis:
	./of_hl7ps -a -l 3 2200
