NAME = valida

CC = gcc
CFLAGS = -Wall -Wextra
LDLIBS =
TARGET = $(NAME)

$(TARGET): $(NAME).y $(NAME).l
	bison -Wall -Wcounterexamples -d -v $(NAME).y
	flex $(NAME).l
	$(CC) $(CFLAGS) $(NAME).tab.c lex.yy.c $(LDLIBS) -o $(TARGET)

.PHONY: clean
clean:
	rm -f $(TARGET) $(NAME).tab.c $(NAME).tab.h lex.yy.c $(NAME).output