class ItemState {
  final bool isNew;
  final bool isLoading;
  final String name;
  final double price;
  final String code;
  final String listId;

  ItemState({
    this.isNew = false,
    this.isLoading = false,
    this.name = '',
    this.price = 0.0,
    this.code = '',
    this.listId = '',
  });

  ItemState copyWith({
    bool? isNew,
    bool? isLoading,
    String? name,
    double? price,
    String? code,
    String? listId,
  }) {
    return ItemState(
      isNew: isNew ?? this.isNew,
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      price: price ?? this.price,
      code: code ?? this.code,
      listId: listId ?? this.listId,
    );
  }
}
