import 'package:flutter/material.dart';

// --- Bad Example: A class with multiple responsibilities ---

class Report {
  final String title;
  final String content;

  Report(this.title, this.content);

  // Responsibility 1: Generating the report content
  String generateReport() {
    return 'Report: $title\n$content';
  }

  // Responsibility 2: Saving the report (simulated)
  void saveReport() {
    print('Saving report to a file...');
    // In a real app, this would involve file I/O operations.
  }
}

// --- Good Example: Separating responsibilities ---

class ReportData {
  final String title;
  final String content;

  ReportData(this.title, this.content);
}

class ReportGenerator {
  String generateReport(ReportData reportData) {
    return 'Report: ${reportData.title}\n${reportData.content}';
  }
}

class ReportSaver {
  void saveReport(ReportData reportData) {
    print('Saving report to a file...');
    // File I/O logic would go here.
  }
}

// --- UI for the screen ---

class SingleResponsibilityPrincipleScreen extends StatefulWidget {
  const SingleResponsibilityPrincipleScreen({super.key});

  @override
  _SingleResponsibilityPrincipleScreenState createState() =>
      _SingleResponsibilityPrincipleScreenState();
}

class _SingleResponsibilityPrincipleScreenState
    extends State<SingleResponsibilityPrincipleScreen> {
  String _reportContent = '';

  void _runBadExample() {
    final report = Report('Monthly Sales', 'Sales were up by 10%');
    setState(() {
      _reportContent = report.generateReport();
    });
    report.saveReport(); // This class is doing too much.
  }

  void _runGoodExample() {
    final reportData = ReportData('Quarterly Profits', 'Profits grew by 15%');
    final generator = ReportGenerator();
    final saver = ReportSaver();

    setState(() {
      _reportContent = generator.generateReport(reportData);
    });
    saver.saveReport(reportData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Responsibility Principle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'The Single Responsibility Principle states that a class should have only one reason to change. In other words, a class should have only one job.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bad Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'A single `Report` class handles both report generation and saving. If the report format changes, or the saving mechanism changes, this class needs to be modified.',
            ),
            ElevatedButton(
              onPressed: _runBadExample,
              child: const Text('Run Bad Example'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Good Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'We have three classes: `ReportData` to hold the data, `ReportGenerator` to create the report, and `ReportSaver` to save it. Each class has a single responsibility.',
            ),
            ElevatedButton(
              onPressed: _runGoodExample,
              child: const Text('Run Good Example'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Generated Report Content:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _reportContent,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
