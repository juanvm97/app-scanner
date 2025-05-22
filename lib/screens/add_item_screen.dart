import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_scanner/providers/code_provider.dart';
import 'package:app_scanner/services/list_service.dart';

class AddItemScreen extends ConsumerWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(messageProvider);
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final barcodeController = TextEditingController(text: code);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Agregar Producto',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.barcode_reader),
                    onPressed: () {
                      Navigator.pushNamed(context, '/scanner');
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Producto',
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Por favor ingrese un precio válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: barcodeController,
                decoration: const InputDecoration(
                  labelText: 'Código de Barras',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor escanee un código de barras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final name = nameController.text;
                    final price = double.parse(priceController.text);
                    final barcode = barcodeController.text;
                    ListService().addItem(
                      id: barcode,
                      name: name,
                      price: price,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto agregado')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
