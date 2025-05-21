import 'package:app_scanner/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListService {
  final CollectionReference itemsRef = FirebaseFirestore.instance
      .collection('users')
      .doc('54321')
      .collection('lists')
      .doc('uZqNTu237Bj6Mq7BhaCT')
      .collection('items');

  Stream<List<Product>> getProductsStream() {
    return itemsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<Product>> getProductsOnce() async {
    final snapshot = await itemsRef.get();
    return snapshot.docs.map((doc) {
      return Product.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
