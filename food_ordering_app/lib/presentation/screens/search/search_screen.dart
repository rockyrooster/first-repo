import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../providers/menu_provider.dart';
import '../../../providers/cart_provider.dart';
import '../../widgets/menu/menu_item_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search food, coffee...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        context.read<MenuProvider>().searchItems('');
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              context.read<MenuProvider>().searchItems(value);
            },
          ),
        ),
      ),
      body: Consumer<MenuProvider>(
        builder: (context, menuProvider, child) {
          if (_searchController.text.isEmpty) {
            return _buildRecentAndPopular(menuProvider);
          }

          if (menuProvider.menuItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off,
                    size: 64,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No results for "${_searchController.text}"',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try different keywords',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: menuProvider.menuItems.length,
            itemBuilder: (context, index) {
              final item = menuProvider.menuItems[index];
              return MenuItemCard(
                item: item,
                onTap: () => context.push('/item/${item.id}'),
                onAddToCart: () {
                  context.read<CartProvider>().addItem(
                    menuItem: item,
                    quantity: 1,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} added to cart')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRecentAndPopular(MenuProvider menuProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular Searches', style: AppTextStyles.headlineSmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Coffee',
              'Latte',
              'Breakfast',
              'Desserts',
              'Healthy',
              'Vegan',
            ].map((tag) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = tag;
                  context.read<MenuProvider>().searchItems(tag);
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(tag, style: AppTextStyles.labelMedium),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text('All Items', style: AppTextStyles.headlineSmall),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: menuProvider.menuItems.length,
            itemBuilder: (context, index) {
              final item = menuProvider.menuItems[index];
              return MenuItemCard(
                item: item,
                onTap: () => context.push('/item/${item.id}'),
                onAddToCart: () {
                  context.read<CartProvider>().addItem(
                    menuItem: item,
                    quantity: 1,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} added to cart')),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
