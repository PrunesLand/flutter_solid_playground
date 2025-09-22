import 'package:flutter/material.dart';

// --- Bad Example: High-level module depends on low-level module ---

class EmailService {
  String sendEmail() => 'Sending email...';
}

class BadNotificationService {
  final EmailService _emailService = EmailService();

  String sendNotification() {
    return _emailService.sendEmail();
  }
}

// --- Good Example: Both modules depend on an abstraction ---

abstract class MessageService {
  String send();
}

class GoodEmailService implements MessageService {
  @override
  String send() => 'Sending email...';
}

class SmsService implements MessageService {
  @override
  String send() => 'Sending SMS...';
}

class GoodNotificationService {
  final MessageService _messageService;

  GoodNotificationService(this._messageService);

  String sendNotification() {
    return _messageService.send();
  }
}


// --- UI for the screen ---

class DependencyInversionPrincipleScreen extends StatefulWidget {
  const DependencyInversionPrincipleScreen({super.key});

  @override
  _DependencyInversionPrincipleScreenState createState() =>
      _DependencyInversionPrincipleScreenState();
}

class _DependencyInversionPrincipleScreenState
    extends State<DependencyInversionPrincipleScreen> {
  String _notificationResult = '';

  void _runBadExample() {
    final notificationService = BadNotificationService();
    setState(() {
      _notificationResult = notificationService.sendNotification();
    });
  }

  void _runGoodExample(MessageService messageService) {
    final notificationService = GoodNotificationService(messageService);
    setState(() {
      _notificationResult = notificationService.sendNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependency Inversion Principle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'The Dependency Inversion Principle states that high-level modules should not depend on low-level modules. Both should depend on abstractions.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bad Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'The `BadNotificationService` (high-level) directly depends on the `EmailService` (low-level). To use a different notification method, the service must be changed.',
            ),
            ElevatedButton(
              onPressed: _runBadExample,
              child: const Text('Send Email (Bad Way)'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Good Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'The `GoodNotificationService` depends on the `MessageService` abstraction. We can inject any service that implements the interface (e.g., email or SMS).',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _runGoodExample(GoodEmailService()),
                  child: const Text('Send Email'),
                ),
                ElevatedButton(
                  onPressed: () => _runGoodExample(SmsService()),
                  child: const Text('Send SMS'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Notification Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _notificationResult,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
