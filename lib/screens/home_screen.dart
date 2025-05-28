import 'package:app_scanner/providers/item_controller.dart';
import 'package:app_scanner/widgets/shopping_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Crea una lista",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 32),
            ShoppingLists(),
            SizedBox(height: 128),
            Center(
              child: FilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      String listName = '';
                      return AlertDialog(
                        title: Text('Crea una lista'),
                        content: TextField(
                          onChanged: (value) {
                            listName = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Nombre de la lista',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              if (listName.isNotEmpty) {
                                final listId = await ref
                                    .read(itemStateNotifierProvider.notifier)
                                    .addList(listName);
                                if (context.mounted) {
                                  context.pop();
                                  context.push('/list/$listId');
                                }
                              }
                            },
                            child: Text('Crear'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("CREAR"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
