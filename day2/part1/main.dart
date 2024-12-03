import 'dart:io';

bool isReportSafe(List<int> report) {
  var reportDir = 0;

  for (int i = 1; i < report.length; i++) {
    final currValue = report[i];
    final lastValue = report[i - 1];

    if (currValue == lastValue) return false;

    var difference = lastValue - currValue;
    if (difference.abs() > 3) return false;

    var currDir = difference.sign;

    if (reportDir == 0)
      reportDir = currDir;
    else if (reportDir != currDir) return false;
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
