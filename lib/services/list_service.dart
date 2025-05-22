import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_scanner/models/item.dart';

class ListService {
  final CollectionReference itemsRef = FirebaseFirestore.instance
      .collection('users')
      .doc('54321')
      .collection('lists')
      .doc('uZqNTu237Bj6Mq7BhaCT')
      .collection('items');

  Stream<List<Item>> getItemsStream() {
    return itemsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Item.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<Item>> getItemsOnce() async {
    final snapshot = await itemsRef.get();
    return snapshot.docs.map((doc) {
      return Item.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> addItem({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) async {
    final item = Item(id: id, name: name, price: price, quantity: quantity);

    await itemsRef.doc(id).set(item.toMap());
  }

  Future<void> removeItem(String id) async {
    await itemsRef.doc(id).delete();
  }
}
