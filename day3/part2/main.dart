import 'dart:io';

Map<int, String> getContentWithIndexes(Iterable<RegExpMatch> matches) {
  return Map<int, String>.fromIterable(matches,
      key: (match) => match.start,
      value: (match) => match.input.substring(match.start, match.end));
}

int executeMul(String mul) {
  final numbers = mul
      .replaceAll('mul(', '')
      .replaceAll(')', '')
      .split(',')
      .map((e) => int.parse(e))
      .toList();

  return numbers[0] * numbers[1];
}

void main() async {
  // Read input file
  final inputFile = File('input.txt');

  final programMemory = inputFile.readAsStringSync();

  final mulRegex = RegExp(r'mul\(\d+,\d+\)');
  final doRegex = RegExp(r'do\(\)');
  final dontRegex = RegExp(r"don't\(\)");

  final mulMatches = mulRegex.allMatches(programMemory);
  final doMatches = doRegex.allMatches(programMemory);
  final dontMatches = dontRegex.allMatches(programMemory);

  final mulIndexes = getContentWithIndexes(mulMatches);
  final doIndexes = getContentWithIndexes(doMatches);
  final dontIndexes = getContentWithIndexes(dontMatches);

  final program = [
    ...mulIndexes.entries,
    ...doIndexes.entries,
    ...dontIndexes.entries
  ];

  program.sort((a, b) => a.key.compareTo(b.key));

  final instructions = program.map((e) => e.value).toList();

  var sum = 0;

  var execute = true;

  for (final instruction in instructions) {
    print(instruction);

    if (instruction == 'don\'t()') {
      execute = false;
    } else if (instruction == 'do()') {
      execute = true;
    } else if (execute && instruction.startsWith('mul')) {
      sum += executeMul(instruction);
    }
  }

  print(sum);
}
