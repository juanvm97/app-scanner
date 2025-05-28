import 'package:app_scanner/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_scanner/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Lista de Compras',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 249, 254),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF49B7EE),
          primary: const Color(0xFF49B7EE),
          secondary: const Color(0xFF1A9BDD),
          tertiary: const Color(0xFF0D7CBC),
          surface: const Color(0xFFF1F9FE),
          error: const Color(0xFFFF5252),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onTertiary: Colors.white,
          onSurface: Colors.black87,
          onError: Colors.white,
        ),
        primarySwatch: MaterialColor(0xFF49B7EE, {
          50: Color(0xFFF1F9FE),
          100: Color(0xFFE2F1FC),
          200: Color(0xFFBEE3F9),
          300: Color(0xFF84CEF5),
          400: Color(0xFF49B7EE),
          500: Color(0xFF1A9BDD),
          600: Color(0xFF0D7CBC),
          700: Color(0xFF0C6298),
          800: Color(0xFF0E547E),
          900: Color(0xFF114769),
        }),
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
