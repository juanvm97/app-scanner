import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app_scanner/models/product.dart';

class ProductService {
  final CollectionReference productsRef = FirebaseFirestore.instance.collection(
    'products',
  );

  /// Crear un nuevo producto
  Future<void> addProduct({
    required String id,
    required String name,
    required double price,
  }) async {
    final product = Product(id: id, name: name, price: price);
    await productsRef.doc(id).set(product.toMap());
  }

  Stream<List<Product>> getProductsStream() {
    return productsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<List<Product>> getProductsOnce() async {
    final snapshot = await productsRef.get();
    return snapshot.docs.map((doc) {
      return Product.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<Product?> getProductById(String id) async {
    final docSnapshot = await productsRef.doc(id).get();

    if (docSnapshot.exists) {
      return Product.fromDocument(
        docSnapshot.id,
        docSnapshot.data() as Map<String, dynamic>,
      );
    } else {
      return null;
    }
  }

  /// Actualizar un producto por ID
  Future<void> updateProduct(String id, {String? name, double? price}) async {
    final Map<String, dynamic> dataToUpdate = {};
    if (name != null) dataToUpdate['name'] = name;
    if (price != null) dataToUpdate['price'] = price;
    await productsRef.doc(id).update(dataToUpdate);
  }

  /// Eliminar un producto por ID
  Future<void> deleteProduct(String id) async {
    await productsRef.doc(id).delete();
  }

  Future<List<Product>> searchProductsByName(String name) async {
    final snapshot = await productsRef.orderBy('name').startAt([name]).get();

    return snapshot.docs.map((doc) {
      return Product.fromDocument(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
