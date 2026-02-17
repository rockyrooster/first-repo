import 'package:equatable/equatable.dart';
import 'menu_item_model.dart';

class CartItemModel extends Equatable {
  final String id; // Unique cart item ID
  final String menuItemId;
  final MenuItemModel menuItem;
  final int quantity;
  final Map<String, List<String>> selectedCustomizations;
  final String? specialInstructions;

  const CartItemModel({
    required this.id,
    required this.menuItemId,
    required this.menuItem,
    required this.quantity,
    this.selectedCustomizations = const {},
    this.specialInstructions,
  });

  /// Calculate total price including customizations
  double get totalPrice {
    double basePrice = menuItem.price;
    double customizationPrice = 0.0;

    // Add customization costs
    for (final entry in selectedCustomizations.entries) {
      final optionId = entry.key;
      final selectedChoiceIds = entry.value;

      // Find the customization option
      final option = menuItem.customizations.firstWhere(
        (opt) => opt.id == optionId,
        orElse: () => const CustomizationOption(
          id: '',
          name: '',
          type: CustomizationType.single,
          choices: [],
        ),
      );

      // Calculate price for selected choices
      for (final choiceId in selectedChoiceIds) {
        final choice = option.choices.firstWhere(
          (c) => c.id == choiceId,
          orElse: () => const CustomizationChoice(id: '', name: ''),
        );
        customizationPrice += choice.additionalPrice;
      }
    }

    return (basePrice + customizationPrice) * quantity;
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      menuItemId: json['menuItemId'] as String,
      menuItem: MenuItemModel.fromJson(json['menuItem'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      selectedCustomizations: (json['selectedCustomizations'] as Map<String, dynamic>?)
              ?.map(
            (key, value) => MapEntry(
              key,
              (value as List<dynamic>).cast<String>(),
            ),
          ) ??
          {},
      specialInstructions: json['specialInstructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuItemId': menuItemId,
      'menuItem': menuItem.toJson(),
      'quantity': quantity,
      'selectedCustomizations': selectedCustomizations,
      'specialInstructions': specialInstructions,
    };
  }

  CartItemModel copyWith({
    String? id,
    String? menuItemId,
    MenuItemModel? menuItem,
    int? quantity,
    Map<String, List<String>>? selectedCustomizations,
    String? specialInstructions,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      selectedCustomizations: selectedCustomizations ?? this.selectedCustomizations,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        menuItemId,
        menuItem,
        quantity,
        selectedCustomizations,
        specialInstructions,
      ];
}
