import 'package:app_scanner/models/shopping_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_scanner/models/item.dart';

class ListService {
  final CollectionReference listsRef = FirebaseFirestore.instance
      .collection('users')
      .doc('54321')
      .collection('lists');

  Future<List<ShoppingList>> getShoppingLists() async {
    final snapshot = await listsRef.get();
    return snapshot.docs.map((doc) {
      return ShoppingList.fromDocument(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
    }).toList();
  }

  Future<String> addShoppingList(String name) async {
    final newList = ShoppingList(id: '', name: name);
    final documentReference = await listsRef.add(newList.toMap());

    return documentReference.id;
  }

  Future<void> removeShoppingList(String id) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc('54321')
        .collection('lists')
        .doc(id);
    await ref.delete();
  }

  Stream<List<Item>> getItemsStream(String listId) {
    if (listId.isEmpty) {
      return Stream.value([]);
    }
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc('54321')
        .collection('lists')
        .doc(listId)
        .collection('items');
    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Item.fromDocument(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> addItem({
    required String id,
    required String name,
    required double price,
    required int quantity,
    required String listId,
  }) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc('54321')
        .collection('lists')
        .doc(listId)
        .collection('items');

    final item = Item(id: id, name: name, price: price, quantity: quantity);

    await ref.doc(id).set(item.toMap());
  }

  Future<void> removeItem(String listId, String id) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc('54321')
        .collection('lists')
        .doc(listId)
        .collection('items');
    await ref.doc(id).delete();
  }

  Future<void> updateItemQuantity(
    String listId,
    String id,
    int quantity,
  ) async {
    if (quantity < 0) {
      quantity = 0;
    }
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc('54321')
        .collection('lists')
        .doc(listId)
        .collection('items');
    await ref.doc(id).update({'quantity': quantity});
  }
}
