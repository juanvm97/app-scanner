import 'package:app_scanner/models/item.dart';
import 'package:app_scanner/widgets/item_card.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;
  const ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(5, 0, 0, 0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 64, child: Text('Nombre')),
                  SizedBox(width: 64, child: Text('Precio')),
                  SizedBox(width: 64, child: Text('Cantidad')),
                  SizedBox(width: 128),
                ],
              ),
            );
          }
          final item = items[index - 1];
          return ItemCard(item: item);
        },
      ),
    );
  }
}
