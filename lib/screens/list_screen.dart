import 'package:app_scanner/providers/item_controller.dart';
import 'package:flutter/material.dart';

import 'package:app_scanner/models/item.dart';
import 'package:app_scanner/services/list_service.dart';
import 'package:app_scanner/widgets/item_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListScreen extends ConsumerStatefulWidget {
  final String listId;

  const ListScreen({required this.listId, super.key});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(itemStateNotifierProvider.notifier).setListId(widget.listId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Productos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: ListService().getItemsStream(widget.listId),
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
          context.push('/add-item');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
