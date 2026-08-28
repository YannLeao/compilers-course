CC = gcc
CFLAGS = -Wall -Wextra
LDLIBS = -lm
TARGET = declaration

$(TARGET): declaration.y declaration.l
	bison -Wall -Wcounterexamples -d -v declaration.y
	flex declaration.l
	$(CC) $(CFLAGS) declaration.tab.c lex.yy.c $(LDLIBS) -o $(TARGET)

.PHONY: clean
clean:
	rm -f $(TARGET) declaration.tab.c declaration.tab.h lex.yy.c declaration.output