import 'package:flutter/material.dart';

import 'package:app_scanner/models/item.dart';
import 'package:app_scanner/services/list_service.dart';
import 'package:app_scanner/widgets/item_list.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Productos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: ListService().getItemsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No hay productos disponibles'),
                  );
                }
                final items = snapshot.data as List<Item>;
                return ItemList(items: items);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-item');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
