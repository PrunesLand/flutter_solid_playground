import 'package:flutter/material.dart';

// --- Bad Example: Fat interface ---

abstract class Worker {
  String work();
  String eat(); // This method is not applicable to all workers.
}

class HumanWorker implements Worker {
  @override
  String work() => 'Human is working.';
  @override
  String eat() => 'Human is eating.';
}

class RobotWorker implements Worker {
  @override
  String work() => 'Robot is working.';
  @override
  String eat() {
    // This is problematic. Robots don't eat.
    // We are forced to implement a method that doesn't make sense.
    return 'Robot cannot eat.';
  }
}

// --- Good Example: Segregated interfaces ---

abstract class Workable {
  String work();
}

abstract class Eatable {
  String eat();
}

class GoodHumanWorker implements Workable, Eatable {
  @override
  String work() => 'Human is working.';
  @override
  String eat() => 'Human is eating.';
}

class GoodRobotWorker implements Workable {
  @override
  String work() => 'Robot is working.';
}


// --- UI for the screen ---

class InterfaceSegregationPrincipleScreen extends StatefulWidget {
  const InterfaceSegregationPrincipleScreen({super.key});

  @override
  _InterfaceSegregationPrincipleScreenState createState() =>
      _InterfaceSegregationPrincipleScreenState();
}

class _InterfaceSegregationPrincipleScreenState
    extends State<InterfaceSegregationPrincipleScreen> {
  String _workerActionResult = '';

  void _runBadExample() {
    final human = HumanWorker();
    final robot = RobotWorker();
    setState(() {
      _workerActionResult = '${human.work()}\n${human.eat()}\n${robot.work()}\n${robot.eat()}';
    });
  }

  void _runGoodExample() {
    final human = GoodHumanWorker();
    final robot = GoodRobotWorker();
    setState(() {
      _workerActionResult = '${human.work()}\n${human.eat()}\n${robot.work()}';
      // The robot doesn't have an eat() method, which is correct.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interface Segregation Principle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'The Interface Segregation Principle states that no client should be forced to depend on methods it does not use.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bad Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'A single `Worker` interface has `work()` and `eat()`. A `RobotWorker` is forced to implement `eat()`, even though it cannot eat. This is a "fat" interface.',
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
              'We have smaller interfaces: `Workable` and `Eatable`. Classes can implement only the interfaces they need. `GoodRobotWorker` only implements `Workable`.',
            ),
            ElevatedButton(
              onPressed: _runGoodExample,
              child: const Text('Run Good Example'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Worker Action Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _workerActionResult,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
