import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_scanner/screens/add_item_screen.dart';
import 'package:app_scanner/screens/home_screen.dart';
import 'package:app_scanner/screens/list_screen.dart';
import 'package:app_scanner/firebase_options.dart';
import 'package:app_scanner/screens/barcode_scanner_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escáner de Código de Barras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/scanner': (context) => const BarcodeScannerScreen(),
        '/list': (context) => ListScreen(),
        '/add-item': (context) => const AddItemScreen(),
      },
    );
  }
}
