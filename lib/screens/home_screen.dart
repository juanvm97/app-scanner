import 'package:app_scanner/widgets/shopping_lists.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            SizedBox(height: 128),
            ShoppingLists(),
            SizedBox(height: 128),
            Center(
              child: FilledButton(
                onPressed: () => context.push('/list/1234'),
                child: Text("CREAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
