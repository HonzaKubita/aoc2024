import 'dart:io';

List<String> correctUpdate(
    List<String> update, Map<String, List<String>> rules) {
  List<String> corrected = List.from(update);

  corrected.sort((a, b) {
    if (rules[b] == null) return 0;
    if (rules[b]!.contains(a)) return -1;

    if (rules[a] == null) return 0;
    if (rules[a]!.contains(b)) return 1;

    return 0;
  });

  return corrected;
}

bool isUpdateValid(List<String> update, Map<String, List<String>> rules) {
  for (int i = 0; i < update.length; i++) {
    final currValue = update[i];
    for (int j = i; j < update.length; j++) {
      final currCheck = update[j];
      if (rules[currValue] != null && rules[currValue]!.contains(currCheck)) {
        return false;
      }
    }
  }

  return true;
}

void main() async {
  // Read input file
  final inputFile = File('input.txt');

  final input = inputFile.readAsStringSync();

  final inputParts = input.split('\n\n');

  final rulesInput = inputParts[0].split('\n').map((e) => e.split('|'));
  final updatesInput = inputParts[1].split('\n').map((e) => e.split(','));

  Map<String, List<String>> rules = {};

  for (final rule in rulesInput) {
    if (rules[rule[1]] == null) rules[rule[1]] = [];
    rules[rule[1]]!.add(rule[0]);
  }

  var sum = 0;

  for (final update in updatesInput) {
    if (!isUpdateValid(update, rules)) {
      var corrected = correctUpdate(update, rules);
      sum += int.parse(corrected[(corrected.length / 2).floor()]);
    }
  }

  print(sum);
}
