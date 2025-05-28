class ShoppingList {
  final String id;
  final String name;

  ShoppingList({required this.id, required this.name});

  factory ShoppingList.fromDocument(String id, Map<String, dynamic> data) {
    return ShoppingList(id: id, name: data['name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
