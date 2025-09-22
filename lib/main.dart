import 'package:flutter/material.dart';

import 'package:solid_principles_app/screens/dependency_inversion_principle_screen.dart';
import 'package:solid_principles_app/screens/interface_segregation_principle_screen.dart';
import 'package:solid_principles_app/screens/liskov_substitution_principle_screen.dart';
import 'package:solid_principles_app/screens/open_closed_principle_screen.dart';
import 'package:solid_principles_app/screens/single_responsibility_principle_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLID Principles Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLID Principles in Flutter'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('S - Single Responsibility Principle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SingleResponsibilityPrincipleScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('O - Open/Closed Principle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OpenClosedPrincipleScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('L - Liskov Substitution Principle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LiskovSubstitutionPrincipleScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('I - Interface Segregation Principle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InterfaceSegregationPrincipleScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('D - Dependency Inversion Principle'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DependencyInversionPrincipleScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
