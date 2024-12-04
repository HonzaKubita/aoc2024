#include <stdio.h>
#include <stdlib.h>

long fileX = 0;
long fileY = 0;

const int size = 140;
const int wordSize = 4;
const char word[wordSize] = "XMAS";

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

int findWordInDir(FILE* file, long posX, long posY, int dirX, int dirY) {
  for (int i = 1; i < wordSize; i++) {
    if (getCharAt(file, posX + (dirX * i), posY + (dirY * i)) != word[i]) {
      return 0;
    }
  }

  return 1;
}

int main() {
  FILE* inputFile;

  inputFile = fopen("./input.txt", "r");

  if (inputFile == NULL) {
    printf("Error opening file\n");
    return 1;
  }

  int wordsFound = 0;

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (getCharAt(inputFile, i, j) == 'X') {
        // Try to find the word in each direction
        wordsFound +=
            findWordInDir(inputFile, i, j, 1, 0) +
            findWordInDir(inputFile, i, j, 0, 1) +
            findWordInDir(inputFile, i, j, -1, 0) +
            findWordInDir(inputFile, i, j, 0, -1) +

            findWordInDir(inputFile, i, j, 1, 1) +
            findWordInDir(inputFile, i, j, -1, -1) +
            findWordInDir(inputFile, i, j, 1, -1) +
            findWordInDir(inputFile, i, j, -1, 1);
      }
    }
  }

  printf("%d\n", wordsFound);

  return 0;
}