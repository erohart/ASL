.ONESHELL:
SHELL := /bin/bash

SRCDIR = ./src
OBJDIR = ./obj
BINDIR = ./bin

TARGET = dico.exe

pre-build: $(BINDIR) $(OBJDIR) $(TARGET)
	
$(TARGET): $(OBJDIR)/dico.l.c $(OBJDIR)/dico.y.c
	gcc -o $(BINDIR)/$(TARGET) $(OBJDIR)/dico.y.c -ly -ll
$(OBJDIR)/dico.y.c:
	yacc -o $(OBJDIR)/dico.y.c $(SRCDIR)/dico.yacc
$(OBJDIR)/dico.l.c:
	lex -o $(OBJDIR)/dico.l.c $(SRCDIR)/dico.lex
$(OBJDIR):
	mkdir $(OBJDIR)
$(BINDIR):
	mkdir $(BINDIR)
clean:
	rm -rf $(BINDIR)
	rm -rf $(OBJDIR)
