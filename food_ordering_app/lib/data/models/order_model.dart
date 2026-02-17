import 'package:equatable/equatable.dart';
import 'cart_item_model.dart';
import 'user_model.dart';

class OrderModel extends Equatable {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final OrderStatus status;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final Address deliveryAddress;
  final OrderType orderType;
  final DateTime createdAt;
  final DateTime? estimatedDelivery;
  final String? specialInstructions;
  final PaymentMethod paymentMethod;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.deliveryAddress,
    required this.orderType,
    required this.createdAt,
    this.estimatedDelivery,
    this.specialInstructions,
    this.paymentMethod = PaymentMethod.card,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      deliveryAddress: Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      orderType: OrderType.values.firstWhere(
        (e) => e.name == json['orderType'],
        orElse: () => OrderType.delivery,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      estimatedDelivery: json['estimatedDelivery'] != null
          ? DateTime.parse(json['estimatedDelivery'] as String)
          : null,
      specialInstructions: json['specialInstructions'] as String?,
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['paymentMethod'],
        orElse: () => PaymentMethod.card,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'status': status.name,
      'subtotal': subtotal,
      'tax': tax,
      'deliveryFee': deliveryFee,
      'total': total,
      'deliveryAddress': deliveryAddress.toJson(),
      'orderType': orderType.name,
      'createdAt': createdAt.toIso8601String(),
      'estimatedDelivery': estimatedDelivery?.toIso8601String(),
      'specialInstructions': specialInstructions,
      'paymentMethod': paymentMethod.name,
    };
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    List<CartItemModel>? items,
    OrderStatus? status,
    double? subtotal,
    double? tax,
    double? deliveryFee,
    double? total,
    Address? deliveryAddress,
    OrderType? orderType,
    DateTime? createdAt,
    DateTime? estimatedDelivery,
    String? specialInstructions,
    PaymentMethod? paymentMethod,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      orderType: orderType ?? this.orderType,
      createdAt: createdAt ?? this.createdAt,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      specialInstructions: specialInstructions ?? this.specialInstructions,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        status,
        subtotal,
        tax,
        deliveryFee,
        total,
        deliveryAddress,
        orderType,
        createdAt,
        estimatedDelivery,
        specialInstructions,
        paymentMethod,
      ];
}

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled,
}

enum OrderType {
  delivery,
  pickup,
}

enum PaymentMethod {
  card,
  cash,
  applePay,
  googlePay,
}

// Extension to get display text for order status
extension OrderStatusExtension on OrderStatus {
  String get displayText {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case OrderStatus.pending:
        return 'Your order is being processed';
      case OrderStatus.confirmed:
        return 'Your order has been confirmed';
      case OrderStatus.preparing:
        return 'Your order is being prepared';
      case OrderStatus.ready:
        return 'Your order is ready for pickup';
      case OrderStatus.outForDelivery:
        return 'Your order is on its way';
      case OrderStatus.delivered:
        return 'Your order has been delivered';
      case OrderStatus.cancelled:
        return 'Your order has been cancelled';
    }
  }
}
