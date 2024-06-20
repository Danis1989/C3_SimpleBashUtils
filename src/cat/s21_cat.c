#include "s21_cat.h"

int main(int argc, char *argv[]) {
  struct flags flag;
  flag.flag_b = 0;
  flag.flag_e = 0;
  flag.flag_n = 0;
  flag.flag_s = 0;
  flag.flag_t = 0;
  flag.flag_v = 0;

  int arg;
  const char *short_options = "+benstv";

  const struct option long_options[] = {{"number-nonblank", 0, NULL, 'b'},
                                        {"number", 0, NULL, 'n'},
                                        {"squeeze-blank", 0, NULL, 's'},
                                        {NULL, 0, NULL, 0}};

  while ((arg = getopt_long(argc, argv, short_options, long_options, NULL)) !=
         -1) {
    if (arg == 'b') {
      flag.flag_b = 1;
    }
    if (arg == 'e') {
      flag.flag_e = 1;
    }
    if (arg == 'n') {
      flag.flag_n = 1;
    }
    if (arg == 's') {
      flag.flag_s = 1;
    }
    if (arg == 't') {
      flag.flag_t = 1;
    }
    if (arg == 'v') {
      flag.flag_v = 1;
    }
  }
  file(argv, argc, flag);
}

void file(char *argv[], int argc, struct flags flag) {
  for (int i = optind; i < argc; i++) {
    FILE *File = fopen(argv[i], "r");
    if (File) {
      Cat_21(File, flag);
      fclose(File);

    } else {
      fprintf(stderr, "No such file or directory\n");
    }
  }
}

void Cat_21(FILE *File, struct flags flag) {
  int i = 1;
  char ch;
  char last_char = '\n';
  char last_last_char = 'k';
  int new_line_count = 1;

  while ((ch = fgetc(File)) != EOF) {
    if (flag.flag_s && ch == '\n' && last_char == '\n' &&
        last_last_char == '\n') {
      if (new_line_count == 1) {
        continue;
      }
    }
    if (flag.flag_n && !flag.flag_b && last_char == '\n') {
      printf("%6d\t", i);
      i++;
    } else if (flag.flag_b && last_char == '\n' && ch != '\n') {
      printf("%6d\t", i);
      i++;
    }
    if ((flag.flag_e || flag.flag_t || flag.flag_v) && (ch < 32 || ch >= 127) &&
        ch != 10 && ch != 9) {
      printf("^");
      ch = ch ^ 64;
    }
    if (flag.flag_e && ch == '\n') {
      printf("$");
    }
    if (flag.flag_t && ch == '\t') {
      printf("^");
      ch = 'I';
    }

    if (new_line_count == 1) printf("%c", ch);

    last_last_char = last_char;
    last_char = ch;
  }
}
