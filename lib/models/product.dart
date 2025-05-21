class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  // Convertir Firestore data en Product
  factory Product.fromDocument(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] as num).toDouble(),
    );
  }

  // Convertir Product en Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price};
  }
}
