.ONESHELL:
SHELL := /bin/bash

SRCDIR = src
OBJDIR = obj
BINDIR = bin

TARGET = $(BINDIR)/ASL

pre-build: clean $(BINDIR) $(OBJDIR) $(TARGET)
	
$(TARGET): $(OBJDIR)/lex.yy.c $(OBJDIR)/y.tab.c
	gcc $(OBJDIR)/lex.yy.c $(OBJDIR)/y.tab.c -o $(TARGET) -ly -ll
$(OBJDIR)/y.tab.c:
	yacc -d -y $(SRCDIR)/traducteur.y -o $(OBJDIR)/y.tab.c
$(OBJDIR)/lex.yy.c:
	lex -o $(OBJDIR)/lex.yy.c $(SRCDIR)/traducteur.l
$(OBJDIR):
	mkdir $(OBJDIR)
$(BINDIR):
	mkdir $(BINDIR)
clean:
	rm -rf $(BINDIR) $(OBJDIR) 
