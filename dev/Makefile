RAKU    := raku
LIBPATH := ./lib

TESTS   := t/*.t
GTESTS  := good/*.t
BTESTS  := bad/*.t
EG      := examples/*.raku

.PHONY: test good bad eg all

default: test

# the original test suite (i.e., 'make test')
test:
	for f in $(TESTS) ; do \
	    RAKULIB=$(LIBPATH) prove -v --exec=$(RAKU) $$f ; \
	done
	RAKULIB=$(LIBPATH) $(RAKU) resources/demo-avl-tree.raku

good:
	for f in $(GTESTS) ; do \
	    RAKULIB=$(LIBPATH) prove -v --exec=$(RAKU) $$f ; \
	done

bad:
	for f in $(BTESTS) ; do \
	    RAKULIB=$(LIBPATH) prove -v --exec=$(RAKU) $$f ; \
	done

eg:
	for f in $(EG) ; do \
	    RAKULIB=$(LIBPATH) $$f ; \
	done

all: test eg
