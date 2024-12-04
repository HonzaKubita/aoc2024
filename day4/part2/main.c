#include <stdio.h>
#include <stdlib.h>

long fileX = 0;
long fileY = 0;

const int size = 140;
const int wordSize = 4;
const char word[wordSize] = "MAS";

char getCharAt(FILE* file, long x, long y) {
  if (x < 0 || y < 0 || x > size - 1 || y > size - 1) {
    return 0;
  }

  long distanceX = x - fileX;
  long distanceY = y - fileY;
  long distanceYOnX = (distanceY * size) + distanceY;  // + distanceY is a compensation of \n at the end of each line
  long distance = distanceX + distanceYOnX;

  fileX = x + 1;  // +1 is a compensation for fgetc that happens when reading the char
  fileY = y;

  fseek(file, distance, SEEK_CUR);

  return (char)fgetc(file);
}

int checkCrossAt(FILE* file, long posX, long posY) {
  int firstPart = abs(getCharAt(file, posX - 1, posY - 1) - getCharAt(file, posX + 1, posY + 1)) == 6;
  int secondPart = abs(getCharAt(file, posX + 1, posY - 1) - getCharAt(file, posX - 1, posY + 1)) == 6;

  return firstPart && secondPart;
}

int main() {
  FILE* inputFile;

  inputFile = fopen("./input.txt", "r");

  if (inputFile == NULL) {
    printf("Error opening file\n");
    return 1;
  }

  int crossesFound = 0;

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (getCharAt(inputFile, i, j) == 'A') {
        crossesFound += checkCrossAt(inputFile, i, j);
      }
    }
  }

  printf("%d\n", crossesFound);

  return 0;
}