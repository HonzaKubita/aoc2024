import 'dart:io';

bool checkPair(int firstValue, int secondValue, int reportDir) {
  if (firstValue == secondValue) return false;

  var difference = firstValue - secondValue;
  if (difference.abs() > 3) return false;

  var pairDir = difference.sign;
  if (pairDir != reportDir) return false;

  return true;
}

bool isReportSafe(List<int> report, {allowedErrors = 1}) {
  var reportDir = (report[0] - report[report.length - 1]).sign;

  for (int i = 0; i < report.length - 1; i++) {
    final currValue = report[i];
    final nextValue = report[i + 1];

    if (checkPair(currValue, nextValue, reportDir) == false) {
      if (allowedErrors > 0) {
        if (isReportSafe(List.from(report)..removeAt(i), allowedErrors: 0))
          return true;

        if (isReportSafe(List.from(report)..removeAt(i + 1), allowedErrors: 0))
          return true;
      }

      return false;
    }
  }

  return true;
}

void main() async {
  // Read input file
  final inputFile = File('input.txt');

  // Put each line of the file into its own string.
  final fileLines = await inputFile.readAsLines();
  // Split
  final reports = fileLines
      .map((String line) => line.split(' ').map((e) => int.parse(e)).toList())
      .toList();

  var safeReports = 0;

  for (final report in reports) {
    if (isReportSafe(report)) {
      safeReports++;
    }
  }

  print(safeReports);
}
