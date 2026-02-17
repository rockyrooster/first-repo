import 'package:flutter/foundation.dart';
import '../data/models/order_model.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/user_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];
  OrderModel? _currentOrder;
  bool _isLoading = false;
  String? _errorMessage;

  List<OrderModel> get orders => List.unmodifiable(_orders);
  OrderModel? get currentOrder => _currentOrder;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Create a new order
  Future<bool> createOrder({
    required String userId,
    required List<CartItemModel> items,
    required Address deliveryAddress,
    required OrderType orderType,
    String? specialInstructions,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Calculate totals
      final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
      final tax = subtotal * 0.08; // 8% tax
      final deliveryFee = orderType == OrderType.delivery && subtotal < 20 ? 5.0 : 0.0;
      final total = subtotal + tax + deliveryFee;

      // Create order
      final order = OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        items: items,
        status: OrderStatus.pending,
        subtotal: subtotal,
        tax: tax,
        deliveryFee: deliveryFee,
        total: total,
        deliveryAddress: deliveryAddress,
        orderType: orderType,
        createdAt: DateTime.now(),
        estimatedDelivery: DateTime.now().add(const Duration(minutes: 30)),
        specialInstructions: specialInstructions,
      );

      // TODO: Save to Firebase
      await Future.delayed(const Duration(seconds: 1));

      _currentOrder = order;
      _orders.insert(0, order);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Load user orders
  Future<void> loadOrders(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Fetch from Firebase
      await Future.delayed(const Duration(seconds: 1));

      // Mock orders would go here
      _orders = [];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update order status (simulating real-time updates)
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex] = _orders[orderIndex].copyWith(status: newStatus);

      if (_currentOrder?.id == orderId) {
        _currentOrder = _currentOrder!.copyWith(status: newStatus);
      }

      notifyListeners();
    }
  }

  /// Get order by ID
  OrderModel? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  /// Clear current order
  void clearCurrentOrder() {
    _currentOrder = null;
    notifyListeners();
  }
}
