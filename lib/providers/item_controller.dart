import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:app_scanner/models/item_state.dart';
import 'package:app_scanner/services/list_service.dart';
import 'package:app_scanner/services/product_service.dart';

part 'item_controller.g.dart';

@Riverpod(keepAlive: true)
class ItemStateNotifier extends _$ItemStateNotifier {
  @override
  ItemState build() {
    return ItemState();
  }

  void setCode(String code) async {
    state = state.copyWith(isLoading: true);
    final product = await ProductService().getProductById(code);
    if (product != null) {
      state = state.copyWith(
        isNew: false,
        isLoading: false,
        name: product.name,
        price: product.price,
        code: code,
      );
    } else {
      state = state.copyWith(
        isNew: true,
        isLoading: false,
        name: '',
        price: 0.0,
        code: code,
      );
    }
  }

  void setListId(String listId) {
    state = state.copyWith(listId: listId);
  }

  Future<String> addList(String name) async {
    state = state.copyWith(isLoading: true);
    final listId = await ListService().addShoppingList(name);
    state = state.copyWith(isLoading: false);

    return listId;
  }

  Future<void> removeList(String listId) async {
    state = state.copyWith(isLoading: true);
    await ListService().removeShoppingList(listId);
    state = state.copyWith(isLoading: false, listId: '');
  }

  void addItem(String barcode, String name, double price, int quantity) async {
    state = state.copyWith(isLoading: true);
    if (state.isNew) {
      await ProductService().addProduct(id: barcode, name: name, price: price);
    }
    await ListService().addItem(
      id: barcode,
      name: name,
      price: price,
      quantity: quantity,
      listId: state.listId,
    );
    state = state.copyWith(isLoading: false, code: '');
  }
}
