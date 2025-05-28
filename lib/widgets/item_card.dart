import 'package:app_scanner/models/item.dart';
import 'package:app_scanner/providers/item_controller.dart';
import 'package:app_scanner/services/list_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemCard extends ConsumerWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get listId from the provider or context if needed
    final listId = ref.read(itemStateNotifierProvider).listId;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFBEE3F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 64, child: Text(item.name)),
          SizedBox(width: 36, child: Text(item.price.toString())),
          SizedBox(width: 36, child: Text(item.quantity.toString())),
          SizedBox(width: 36, child: Text(item.total.toString())),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  ListService().updateItemQuantity(
                    listId,
                    item.id,
                    item.quantity - 1,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  ListService().updateItemQuantity(
                    listId,
                    item.id,
                    item.quantity + 1,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ListService().removeItem(listId, item.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
