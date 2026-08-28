CC = gcc
CFLAGS = -Wall -Wextra
LDLIBS = -lm
TARGET = calculator

$(TARGET): calculator.y calculator.l
	bison -Wall -Wcounterexamples -d -v calculator.y
	flex calculator.l
	$(CC) $(CFLAGS) calculator.tab.c lex.yy.c $(LDLIBS) -o $(TARGET)

.PHONY: clean
clean:
	rm -f $(TARGET) calculator.tab.c calculator.tab.h lex.yy.c calculator.output