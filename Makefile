.PHONY: test all clean install uninstall

RM      = rm -f
CC      = gcc
LIB_A   = libjansson.a
LIB_SO  = libjansson.so
CFLAGS  = -std=c99 -Isrc -Wall -Wno-unused-function -Werror -fPIC
CFLAGS += -Wextra -Wno-unused-parameter -Wno-sign-compare
CFLAGS += -DHAVE_STDINT_H

SRCS = \
	src/dump.c \
	src/error.c \
	src/hashtable.c \
	src/hashtable_seed.c \
	src/load.c \
	src/memory.c \
	src/pack_unpack.c \
	src/strbuffer.c \
	src/strconv.c \
	src/utf.c \
	src/value.c

OBJS = $(SRCS:.c=.o)

all: $(LIB_A) $(LIB_SO)

%.o: %.c
	$(CC) $(CFLAGS) $< -c -o $@ $(CFLAGS)

$(LIB_A): $(OBJS)
	echo $(OBJS)
	ar rcu $@ $(OBJS) 
	ranlib $@

$(LIB_SO): $(OBJS)
	$(CC) -o $@ -shared $?

clean:
	$(foreach c, $(BINS), $(RM) $(c);)
	$(RM) $(OBJS) simple_parse

example: all
	$(CC) examples/simple_parse.c -o simple_parse -I src/ -ljansson -L.
