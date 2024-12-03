#include <stdio.h>
#include <stdlib.h>

int main() {
  FILE* inputFile;

  inputFile = fopen("./input.txt", "r");

  if (inputFile == NULL) {
    printf("Error opening file\n");
    return 1;
  }

  int column1[1000];
  int column2[1000];

  //// Parse input
  int currLineIndex = 0;
  int currCharIndex = 0;
  char currId[5];
  char c;

  while ((c = fgetc(inputFile)) != EOF) {
    if (c == ' ') {
      // End of firs id
      // Store the id
      column1[currLineIndex] = atoi(currId);

      // Reset char index
      currCharIndex = 0;

      // Skip the next two characters
      fseek(inputFile, 2, SEEK_CUR);
    } else if (c == '\n') {
      // End of second id and line
      // Store the id
      column2[currLineIndex] = atoi(currId);

      // Reset char index and raise line index
      currCharIndex = 0;
      currLineIndex++;
    } else {
      // Append char to id
      currId[currCharIndex] = c;
      currCharIndex++;
    }
  }

  // Store the last id
  column2[currLineIndex] = atoi(currId);

  //// Solution logic

  unsigned int similarity = 0;

  for (int i = 0; i < 1000; i++) {
    int base = column1[i];
    int multiplier = 0;
    for (int j = 0; j < 1000; j++) {
      int currNumber = column2[j];
      if (currNumber == base) {
        multiplier++;
      }
    }
    similarity += base * multiplier;
  }

  printf("Output: %d\n", similarity);

  return 0;
}