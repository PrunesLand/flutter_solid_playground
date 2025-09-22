import 'package:flutter/material.dart';

// --- Bad Example: Not open for extension ---

class BadPaymentProcessor {
  String processPayment(String type) {
    if (type == 'credit_card') {
      return 'Processing credit card payment...';
    } else if (type == 'paypal') {
      return 'Processing PayPal payment...';
    }
    // To add a new payment method, we have to modify this class.
    return 'Unknown payment type';
  }
}

// --- Good Example: Open for extension, closed for modification ---

abstract class PaymentMethod {
  String execute();
}

class CreditCardPayment implements PaymentMethod {
  @override
  String execute() {
    return 'Processing credit card payment...';
  }
}

class PayPalPayment implements PaymentMethod {
  @override
  String execute() {
    return 'Processing PayPal payment...';
  }
}

// We can add a new payment method without modifying existing code.
class StripePayment implements PaymentMethod {
  @override
  String execute() {
    return 'Processing Stripe payment...';
  }
}

class GoodPaymentProcessor {
  String processPayment(PaymentMethod paymentMethod) {
    return paymentMethod.execute();
  }
}

// --- UI for the screen ---

class OpenClosedPrincipleScreen extends StatefulWidget {
  const OpenClosedPrincipleScreen({super.key});

  @override
  _OpenClosedPrincipleScreenState createState() =>
      _OpenClosedPrincipleScreenState();
}

class _OpenClosedPrincipleScreenState extends State<OpenClosedPrincipleScreen> {
  String _paymentResult = '';

  void _runBadExample(String type) {
    final processor = BadPaymentProcessor();
    setState(() {
      _paymentResult = processor.processPayment(type);
    });
  }

  void _runGoodExample(PaymentMethod paymentMethod) {
    final processor = GoodPaymentProcessor();
    setState(() {
      _paymentResult = processor.processPayment(paymentMethod);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open/Closed Principle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'The Open/Closed Principle states that software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bad Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'A `BadPaymentProcessor` class uses if-else statements. To add a new payment method, you must modify the class, violating the principle.',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _runBadExample('credit_card'),
                  child: const Text('Credit Card'),
                ),
                ElevatedButton(
                  onPressed: () => _runBadExample('paypal'),
                  child: const Text('PayPal'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Good Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'We use an abstract `PaymentMethod` class. New payment methods can be added by creating new classes that implement this interface, without changing the `GoodPaymentProcessor`.',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _runGoodExample(CreditCardPayment()),
                  child: const Text('Credit Card'),
                ),
                ElevatedButton(
                  onPressed: () => _runGoodExample(PayPalPayment()),
                  child: const Text('PayPal'),
                ),
                ElevatedButton(
                  onPressed: () => _runGoodExample(StripePayment()),
                  child: const Text('Stripe (New)'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _paymentResult,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
