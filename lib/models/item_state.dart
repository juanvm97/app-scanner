class ItemState {
  final bool isNew;
  final bool isLoading;
  final String name;
  final double price;
  final String code;

  ItemState({
    this.isNew = false,
    this.isLoading = false,
    this.name = '',
    this.price = 0.0,
    this.code = '',
  });

  ItemState copyWith({
    bool? isNew,
    bool? isLoading,
    String? name,
    double? price,
    String? code,
  }) {
    return ItemState(
      isNew: isNew ?? this.isNew,
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      price: price ?? this.price,
      code: code ?? this.code,
    );
  }
}
