import 'package:app_scanner/models/item.dart';
import 'package:app_scanner/services/list_service.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(5, 0, 0, 0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 64, child: Text(item.name)),
          SizedBox(width: 36, child: Text(item.price.toString())),
          SizedBox(width: 36, child: Text(item.quantity.toString())),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // Decrementar
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  // Incrementar
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ListService().removeItem(item.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
