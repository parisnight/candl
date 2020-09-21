# Makefile for TinyScheme canonical extension library candl
 
#SCHEME_H_DIR=../tinyscheme-1.30 
SCHEME_H_DIR=../tinyscheme-1.42

# Windows/2000 
# CC = cl -nologo 
# DEBUG = -W3 -Z7 -MD 
# SYS_LIBS= 
# Osuf=obj 
# SOsuf=dll 
# LD = link -nologo 
# LDFLAGS = -debug -map -dll -incremental:no 
# OUT = -out:$@ 
 
# Unix, generally 
CC = gcc -fpic 
DEBUG=-g -Wall -Wno-char-subscripts -O 
Osuf=o 
SOsuf=so 
OUT = -o $@ 
 
# Linux 
LD = gcc 
LDFLAGS = -shared 
SYS_LIBS= 
 
# Solaris 
# LD = /usr/ccs/bin/ld 
## -Bsymbolic nec. because we have fns w same name as in libc. 
# LDFLAGS = -G -Bsymbolic -z text 
# SYS_LIBS= -lc 
 
SRCS = candl.c  
OBJS = $(SRCS:.c=.$(Osuf)) 
 
all: candl.$(SOsuf) 
 
%.$(Osuf): %.c 
	$(CC) -c $(DEBUG) -DUSE_DL -I. -I$(SCHEME_H_DIR) $+ 
 
candl.$(SOsuf): $(OBJS) 
	$(LD) $(LDFLAGS) $(OUT) $+ $(SYS_LIBS) 
 
clean: 
	-rm -f $(OBJS) candl.$(SOsuf) 
