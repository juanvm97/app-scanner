import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Crea una lista",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 100),
            Center(
              child: FilledButton(
                onPressed: () => Navigator.pushNamed(context, '/list'),
                child: Text("CREAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
