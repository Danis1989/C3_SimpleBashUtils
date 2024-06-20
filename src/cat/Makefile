CC = gcc
CFLAGS = -Wall -Werror -Wextra -std=c11

all: clean s21_cat

s21_cat: s21_cat.c
	$(CC) s21_cat.c -o s21_cat

rebuild: clean all

clean:
	rm -f *.o s21_cat