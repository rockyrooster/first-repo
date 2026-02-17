import 'package:equatable/equatable.dart';

class MenuItemModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String categoryId;
  final List<String> tags;
  final bool isAvailable;
  final List<CustomizationOption> customizations;
  final NutritionInfo? nutrition;
  final int preparationTime; // in minutes

  const MenuItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.tags = const [],
    this.isAvailable = true,
    this.customizations = const [],
    this.nutrition,
    this.preparationTime = 15,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      categoryId: json['categoryId'] as String,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      isAvailable: json['isAvailable'] as bool? ?? true,
      customizations: (json['customizations'] as List<dynamic>?)
              ?.map((e) => CustomizationOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nutrition: json['nutrition'] != null
          ? NutritionInfo.fromJson(json['nutrition'] as Map<String, dynamic>)
          : null,
      preparationTime: json['preparationTime'] as int? ?? 15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'tags': tags,
      'isAvailable': isAvailable,
      'customizations': customizations.map((e) => e.toJson()).toList(),
      'nutrition': nutrition?.toJson(),
      'preparationTime': preparationTime,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        categoryId,
        tags,
        isAvailable,
        customizations,
        nutrition,
        preparationTime,
      ];
}

class CustomizationOption extends Equatable {
  final String id;
  final String name;
  final CustomizationType type;
  final List<CustomizationChoice> choices;
  final bool isRequired;

  const CustomizationOption({
    required this.id,
    required this.name,
    required this.type,
    required this.choices,
    this.isRequired = false,
  });

  factory CustomizationOption.fromJson(Map<String, dynamic> json) {
    return CustomizationOption(
      id: json['id'] as String,
      name: json['name'] as String,
      type: CustomizationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CustomizationType.single,
      ),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => CustomizationChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      isRequired: json['isRequired'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'choices': choices.map((e) => e.toJson()).toList(),
      'isRequired': isRequired,
    };
  }

  @override
  List<Object?> get props => [id, name, type, choices, isRequired];
}

enum CustomizationType { single, multiple }

class CustomizationChoice extends Equatable {
  final String id;
  final String name;
  final double additionalPrice;

  const CustomizationChoice({
    required this.id,
    required this.name,
    this.additionalPrice = 0.0,
  });

  factory CustomizationChoice.fromJson(Map<String, dynamic> json) {
    return CustomizationChoice(
      id: json['id'] as String,
      name: json['name'] as String,
      additionalPrice: (json['additionalPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'additionalPrice': additionalPrice,
    };
  }

  @override
  List<Object?> get props => [id, name, additionalPrice];
}

class NutritionInfo extends Equatable {
  final int calories;
  final double protein; // grams
  final double carbs; // grams
  final double fat; // grams

  const NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: json['calories'] as int,
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }

  @override
  List<Object?> get props => [calories, protein, carbs, fat];
}
