import 'package:app_scanner/models/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShoppingListCard extends ConsumerWidget {
  final ShoppingList list;

  const ShoppingListCard({super.key, required this.list});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFBEE3F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 64, child: Text(list.name)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.push('/list/${list.id}');
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ListService().removeItem(item.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
