import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_scanner/firebase_options.dart';
import 'package:app_scanner/models/product.dart';
import 'package:app_scanner/providers/code_provider.dart';
import 'package:app_scanner/screens/add_product_screen.dart';
import 'package:app_scanner/screens/barcode_scanner_screen.dart';
import 'package:app_scanner/services/data_service.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(messageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Escáner de código de barras')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerScreen(),
                  ),
                );
              },
              child: const Text('Escanear código'),
            ),
          ),
          message.isNotEmpty
              ? FutureBuilder<Product?>(
                future: DataService().getProductById(message),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    AddProductScreen(productId: message),
                          ),
                        );
                      },
                      child: Text('Producto no encontrado. Agregar Producto'),
                    );
                  }
                  final product = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nombre: ${product.name}',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Precio: \$${product.price}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                },
              )
              : Container(),
        ],
      ),
    );
  }
}
