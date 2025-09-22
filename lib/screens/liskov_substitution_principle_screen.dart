import 'package:flutter/material.dart';

// --- Bad Example: Violating LSP ---

class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  void setWidth(double width) {
    this.width = width;
  }

  void setHeight(double height) {
    this.height = height;
  }

  double get area => width * height;
}

class Square extends Rectangle {
  Square(double side) : super(side, side);

  @override
  void setWidth(double width) {
    super.setWidth(width);
    super.setHeight(width); // Maintains the square property
  }

  @override
  void setHeight(double height) {
    super.setWidth(height);
    super.setHeight(height); // Maintains the square property
  }
}

// --- Good Example: Respecting LSP ---

abstract class Shape {
  double get area;
}

class RectangleShape extends Shape {
  final double width;
  final double height;

  RectangleShape(this.width, this.height);

  @override
  double get area => width * height;
}

class SquareShape extends Shape {
  final double side;

  SquareShape(this.side);

  @override
  double get area => side * side;
}


// --- UI for the screen ---

class LiskovSubstitutionPrincipleScreen extends StatefulWidget {
  const LiskovSubstitutionPrincipleScreen({super.key});

  @override
  _LiskovSubstitutionPrincipleScreenState createState() =>
      _LiskovSubstitutionPrincipleScreenState();
}

class _LiskovSubstitutionPrincipleScreenState
    extends State<LiskovSubstitutionPrincipleScreen> {
  String _areaResult = '';

  void _runBadExample() {
    Rectangle rectangle = Square(10); // Substituting Square for Rectangle
    rectangle.setWidth(20);
    rectangle.setHeight(30);
    // Expected area: 20 * 30 = 600
    // Actual area: 30 * 30 = 900, because setHeight also changed the width.
    // This violates LSP.
    setState(() {
      _areaResult = 'Expected: 600, Actual: ${rectangle.area}';
    });
  }

  void _runGoodExample() {
    Shape shape = RectangleShape(20, 30);
    final shape2 = SquareShape(10);

    setState(() {
      _areaResult = 'Rectangle Area: ${shape.area}\nSquare Area: ${shape2.area}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liskov Substitution Principle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'The Liskov Substitution Principle states that objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bad Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'A `Square` class inherits from `Rectangle`. When a `Square` is used where a `Rectangle` is expected, it can lead to unexpected behavior because setting the height of a square also changes its width.',
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
              'We use an abstract `Shape` class. `RectangleShape` and `SquareShape` are separate implementations. This way, we avoid the substitution problem.',
            ),
            ElevatedButton(
              onPressed: _runGoodExample,
              child: const Text('Run Good Example'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Area Calculation Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _areaResult,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
