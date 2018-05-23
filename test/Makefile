.ONESHELL:
SHELL := /bin/bash

SRCDIR = .
OBJDIR = .
BINDIR = .

TARGET = test

pre-build: clean $(TARGET)
	
$(TARGET): $(OBJDIR)/lex.yy.c $(OBJDIR)/y.tab.c
	gcc $(OBJDIR)/lex.yy.c $(OBJDIR)/y.tab.c -o $(BINDIR)/$(TARGET) -ly -ll
$(OBJDIR)/y.tab.c:
	yacc -d -y $(SRCDIR)/test.y
$(OBJDIR)/lex.yy.c:
	lex $(SRCDIR)/test.l
clean:
	rm -f $(BINDIR)/$(TARGET) y.tab.c y.tab.h lex.yy.c
