import 'package:flutter/material.dart';

import 'package:app_scanner/services/product_service.dart';
import 'package:go_router/go_router.dart';

class AddProductScreen extends StatefulWidget {
  final String productId;
  const AddProductScreen({super.key, required this.productId});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre del Producto'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final price = double.tryParse(_priceController.text) ?? 0.0;

                if (name.isNotEmpty && price > 0) {
                  // Llamamos a la función addProduct del DataService
                  await ProductService().addProduct(
                    id: widget.productId,
                    name: name,
                    price: price,
                  );

                  context.pop();
                } else {
                  // Si los campos son inválidos
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, ingrese datos válidos.'),
                    ),
                  );
                }
              },
              child: Text('Agregar Producto'),
            ),
          ],
        ),
      ),
    );
  }
}
