import 'package:flutter/foundation.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/menu_item_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);
  int get itemCount => _items.length;
  bool get isEmpty => _items.isEmpty;

  /// Calculate subtotal
  double get subtotal {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  /// Calculate tax (8% for example)
  double get tax {
    return subtotal * 0.08;
  }

  /// Calculate delivery fee
  double get deliveryFee {
    return subtotal > 20 ? 0.0 : 5.0;
  }

  /// Calculate total
  double get total {
    return subtotal + tax + deliveryFee;
  }

  /// Add item to cart
  void addItem({
    required MenuItemModel menuItem,
    required int quantity,
    Map<String, List<String>> customizations = const {},
    String? specialInstructions,
  }) {
    final cartItem = CartItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      menuItemId: menuItem.id,
      menuItem: menuItem,
      quantity: quantity,
      selectedCustomizations: customizations,
      specialInstructions: specialInstructions,
    );

    _items.add(cartItem);
    notifyListeners();
  }

  /// Remove item from cart
  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  /// Update item quantity
  void updateQuantity(String cartItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(cartItemId);
      return;
    }

    final index = _items.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  /// Clear cart
  void clear() {
    _items.clear();
    notifyListeners();
  }

  /// Check if item exists in cart
  bool hasItem(String menuItemId) {
    return _items.any((item) => item.menuItemId == menuItemId);
  }

  /// Get item count for a specific menu item
  int getItemQuantity(String menuItemId) {
    return _items
        .where((item) => item.menuItemId == menuItemId)
        .fold(0, (sum, item) => sum + item.quantity);
  }
}
