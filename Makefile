.PHONY: test all clean install uninstall

RM      = rm -f
CC      = gcc
BINS    = libjansson.a
CFLAGS  = -std=c99 -Isrc -Wall -Wpedantic -Wno-unused-function -Werror
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

all: $(BINS)

%.o: %.c
	$(CC) $(CFLAGS) $< -c -o $@ $(CFLAGS)

$(BINS): $(OBJS)
	echo $(OBJS)
	ar rcu $@ $(OBJS) 
	ranlib $@

clean:
	$(foreach c, $(BINS), $(RM) $(c);)
	$(RM) $(OBJS) simple_parse

example: all
	$(CC) examples/simple_parse.c -o simple_parse -I src/ -ljansson -L.
