import 'package:app_scanner/models/shopping_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_scanner/models/item.dart';

class ListService {
  final CollectionReference itemsRef = FirebaseFirestore.instance
      .collection('users')
      .doc('54321')
      .collection('lists')
      .doc('uZqNTu237Bj6Mq7BhaCT')
      .collection('items');
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

  Future<void> removeItem(String id) async {
    await itemsRef.doc(id).delete();
  }

  Future<void> updateItemQuantity(String id, int quantity) async {
    if (quantity < 0) {
      quantity = 0;
    }
    await itemsRef.doc(id).update({'quantity': quantity});
  }
}
