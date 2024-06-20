#ifndef CAT_H
#define CAT_H
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct flags {
  int flag_b;
  int flag_e;
  int flag_n;
  int flag_s;
  int flag_t;
  int flag_v;
};
void Cat_21(FILE *File, struct flags flag);

void file(char *argv[], int argc, struct flags flag);

#endif