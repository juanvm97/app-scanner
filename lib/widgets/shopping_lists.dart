import 'package:app_scanner/providers/item_controller.dart';
import 'package:app_scanner/services/list_service.dart';
import 'package:app_scanner/widgets/shopping_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingLists extends ConsumerWidget {
  const ShoppingLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(itemStateNotifierProvider).isLoading;
    return Expanded(
      child:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder(
                future: ListService().getShoppingLists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                    return const Center(
                      child: Text('No hay listas disponibles'),
                    );
                  }
                  final lists = snapshot.data as List;
                  return ListView.separated(
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 16),
                    itemCount: lists.length,
                    itemBuilder: (context, index) {
                      final item = lists[index];
                      return ShoppingListCard(list: item);
                    },
                  );
                },
              ),
    );
  }
}
