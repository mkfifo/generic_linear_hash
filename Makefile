.POSIX:

include config.mk

SRC = generic_linear_hash.c
OBJ = ${SRC:.c=.o}

EXTRAFLAGS =

# default to error all: generic_linear_hash 
%.o: %.c
	@echo COMPILING CC $< with extra flags \"${EXTRAFLAGS}\"
	@${CC} -g -c ${CFLAGS} $< ${EXTRAFLAGS} -o $@

generic_linear_hash: ${OBJ}
	@echo "ERROR: unable to compile generic_linear_hash on it's own as it is a library"
	exit 1

cleanobj:
	@echo cleaning objects and temporary files
	@find . -iname '*.o' -delete

clean: cleanobj
	@echo cleaning tests
	@rm -f test_glh
	@rm -f example
	@echo cleaning gcov guff
	@find . -iname '*.gcda' -delete
	@find . -iname '*.gcov' -delete
	@find . -iname '*.gcno' -delete


test: run_tests

run_tests: compile_tests
	@echo "\n\nrunning test_glh"
	./test_glh
	@echo "\n"

compile_tests: clean ${OBJ}
	@echo "compiling tests"
	@${CC} test_generic_linear_hash.c -o test_glh ${LDFLAGS} ${OBJ}
	@make -s cleanobj

example: clean ${OBJ}
	@echo "compiling and running example"
	@${CC} example.c -o example ${LDFLAGS} ${OBJ}
	./example

.PHONY: all clean cleanobj generic_linear_hash test example

