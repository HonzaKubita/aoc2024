import 'dart:io';

void main() async {
  // Read input file
  final inputFile = File('input.txt');

  final programMemory = inputFile.readAsStringSync();

  final mulRegex = RegExp(r'mul\(\d+,\d+\)');

  final matches = mulRegex.allMatches(programMemory);

  var sum = 0;

  for (final match in matches) {
    final numbers = programMemory
        .substring(match.start, match.end)
        .replaceAll('mul(', '')
        .replaceAll(')', '')
        .split(',')
        .map((e) => int.parse(e))
        .toList();

    sum += numbers[0] * numbers[1];
  }

  print(sum);
}
