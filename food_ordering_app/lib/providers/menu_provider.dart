import 'package:flutter/foundation.dart';
import '../data/models/menu_item_model.dart';
import '../data/models/category_model.dart';

class MenuProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<MenuItemModel> _menuItems = [];
  List<MenuItemModel> _filteredItems = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedCategoryId;
  String _searchQuery = '';

  List<CategoryModel> get categories => _categories;
  List<MenuItemModel> get menuItems => _filteredItems.isNotEmpty || _searchQuery.isNotEmpty
      ? _filteredItems
      : _menuItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get selectedCategoryId => _selectedCategoryId;

  /// Load categories and menu items
  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual Firebase data fetching
      await Future.delayed(const Duration(seconds: 1));

      // Mock categories
      _categories = [
        const CategoryModel(
          id: '1',
          name: 'Coffee',
          description: 'Hot and cold coffee drinks',
          sortOrder: 1,
        ),
        const CategoryModel(
          id: '2',
          name: 'Food',
          description: 'Breakfast, lunch, and snacks',
          sortOrder: 2,
        ),
        const CategoryModel(
          id: '3',
          name: 'Desserts',
          description: 'Sweet treats and pastries',
          sortOrder: 3,
        ),
        const CategoryModel(
          id: '4',
          name: 'Drinks',
          description: 'Juices, smoothies, and more',
          sortOrder: 4,
        ),
      ];

      // Mock menu items
      _menuItems = [
        const MenuItemModel(
          id: '1',
          name: 'Caramel Latte',
          description: 'Smooth espresso with steamed milk and caramel',
          price: 4.99,
          imageUrl: 'https://via.placeholder.com/400',
          categoryId: '1',
          tags: ['hot', 'coffee', 'sweet'],
          customizations: [
            CustomizationOption(
              id: 'size',
              name: 'Size',
              type: CustomizationType.single,
              isRequired: true,
              choices: [
                CustomizationChoice(id: 'small', name: 'Small'),
                CustomizationChoice(id: 'medium', name: 'Medium', additionalPrice: 1.0),
                CustomizationChoice(id: 'large', name: 'Large', additionalPrice: 2.0),
              ],
            ),
          ],
        ),
        const MenuItemModel(
          id: '2',
          name: 'Avocado Toast',
          description: 'Fresh avocado on artisan sourdough bread',
          price: 8.99,
          imageUrl: 'https://via.placeholder.com/400',
          categoryId: '2',
          tags: ['breakfast', 'healthy'],
        ),
        const MenuItemModel(
          id: '3',
          name: 'Chocolate Croissant',
          description: 'Buttery croissant filled with rich chocolate',
          price: 3.99,
          imageUrl: 'https://via.placeholder.com/400',
          categoryId: '3',
          tags: ['dessert', 'pastry'],
        ),
        const MenuItemModel(
          id: '4',
          name: 'Green Smoothie',
          description: 'Healthy blend of spinach, banana, and mango',
          price: 6.99,
          imageUrl: 'https://via.placeholder.com/400',
          categoryId: '4',
          tags: ['drink', 'healthy', 'vegan'],
        ),
        const MenuItemModel(
          id: '5',
          name: 'Cappuccino',
          description: 'Classic espresso with foamed milk',
          price: 4.49,
          imageUrl: 'https://via.placeholder.com/400',
          categoryId: '1',
          tags: ['hot', 'coffee'],
        ),
      ];

      _filteredItems = _menuItems;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter items by category
  void filterByCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    _applyFilters();
  }

  /// Search items
  void searchItems(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    _filteredItems = _menuItems.where((item) {
      final matchesCategory = _selectedCategoryId == null ||
          item.categoryId == _selectedCategoryId;
      final matchesSearch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery) ||
          item.description.toLowerCase().contains(_searchQuery) ||
          item.tags.any((tag) => tag.toLowerCase().contains(_searchQuery));

      return matchesCategory && matchesSearch;
    }).toList();

    notifyListeners();
  }

  /// Get menu item by ID
  MenuItemModel? getItemById(String id) {
    try {
      return _menuItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get category by ID
  CategoryModel? getCategoryById(String id) {
    try {
      return _categories.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear filters
  void clearFilters() {
    _selectedCategoryId = null;
    _searchQuery = '';
    _filteredItems = _menuItems;
    notifyListeners();
  }
}
