import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/helpers.dart';
import '../../../providers/cart_provider.dart';
import '../../widgets/common/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart', style: AppTextStyles.headlineMedium),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              if (cart.isEmpty) return const SizedBox.shrink();
              return TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear Cart'),
                      content: const Text(
                        'Are you sure you want to remove all items from your cart?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<CartProvider>().clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: AppColors.error),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Clear All'),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: AppColors.textHint,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items to get started',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => context.go(AppRoutes.menu),
                    child: const Text('Browse Menu'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Cart items list
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Dismissible(
                      key: Key(item.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        color: AppColors.error,
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      onDismissed: (_) {
                        cart.removeItem(item.id);
                      },
                      child: Row(
                        children: [
                          // Item image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 72,
                              height: 72,
                              color: AppColors.surfaceVariant,
                              child: const Icon(
                                Icons.fastfood,
                                size: 36,
                                color: AppColors.textHint,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Item details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.menuItem.name,
                                  style: AppTextStyles.titleMedium,
                                ),
                                if (item.specialInstructions != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    item.specialInstructions!,
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Text(
                                  Helpers.formatPrice(item.totalPrice),
                                  style: AppTextStyles.priceSmall,
                                ),
                              ],
                            ),
                          ),

                          // Quantity control
                          Row(
                            children: [
                              _QuantityButton(
                                icon: Icons.remove,
                                onPressed: () => cart.updateQuantity(
                                  item.id,
                                  item.quantity - 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  '${item.quantity}',
                                  style: AppTextStyles.titleMedium,
                                ),
                              ),
                              _QuantityButton(
                                icon: Icons.add,
                                onPressed: () => cart.updateQuantity(
                                  item.id,
                                  item.quantity + 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Order summary
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.overlay,
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _SummaryRow(
                      label: 'Subtotal',
                      value: Helpers.formatPrice(cart.subtotal),
                    ),
                    const SizedBox(height: 8),
                    _SummaryRow(
                      label: 'Tax (8%)',
                      value: Helpers.formatPrice(cart.tax),
                    ),
                    const SizedBox(height: 8),
                    _SummaryRow(
                      label: 'Delivery Fee',
                      value: cart.deliveryFee == 0
                          ? 'Free'
                          : Helpers.formatPrice(cart.deliveryFee),
                      valueColor: cart.deliveryFee == 0 ? AppColors.success : null,
                    ),
                    const Divider(height: 24),
                    _SummaryRow(
                      label: 'Total',
                      value: Helpers.formatPrice(cart.total),
                      isBold: true,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'Proceed to Checkout',
                      onPressed: () => context.push(AppRoutes.checkout),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold ? AppTextStyles.titleMedium : AppTextStyles.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(
          value,
          style: style.copyWith(
            color: valueColor ?? (isBold ? AppColors.primary : null),
          ),
        ),
      ],
    );
  }
}
