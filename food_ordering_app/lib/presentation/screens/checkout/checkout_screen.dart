import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/user_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/order_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  OrderType _orderType = OrderType.delivery;

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final cartProvider = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();
    final authProvider = context.read<AuthProvider>();

    final address = Address(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: 'Delivery',
      street: _streetController.text.trim(),
      city: _cityController.text.trim(),
      state: 'CA',
      zipCode: _zipController.text.trim(),
    );

    final success = await orderProvider.createOrder(
      userId: authProvider.currentUser?.id ?? 'guest',
      items: cartProvider.items,
      deliveryAddress: address,
      orderType: _orderType,
    );

    if (success && mounted) {
      cartProvider.clear();
      context.go(
        '${AppRoutes.orderTracking.replaceAll(':orderId', orderProvider.currentOrder!.id)}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout', style: AppTextStyles.headlineMedium),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order type selection
              Text('Order Type', style: AppTextStyles.headlineSmall),
              const SizedBox(height: 12),
              Row(
                children: [
                  _OrderTypeCard(
                    label: 'Delivery',
                    icon: Icons.delivery_dining,
                    isSelected: _orderType == OrderType.delivery,
                    onTap: () => setState(() => _orderType = OrderType.delivery),
                  ),
                  const SizedBox(width: 16),
                  _OrderTypeCard(
                    label: 'Pickup',
                    icon: Icons.store,
                    isSelected: _orderType == OrderType.pickup,
                    onTap: () => setState(() => _orderType = OrderType.pickup),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Delivery Address (only for delivery)
              if (_orderType == OrderType.delivery) ...[
                Text('Delivery Address', style: AppTextStyles.headlineSmall),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _streetController,
                  label: 'Street Address',
                  hint: '123 Main St',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Street address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        controller: _cityController,
                        label: 'City',
                        hint: 'New York',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: _zipController,
                        label: 'ZIP',
                        hint: '10001',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],

              // Payment section (Mock)
              Text('Payment', style: AppTextStyles.headlineSmall),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.divider),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.credit_card, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Visa ending in 4242', style: AppTextStyles.titleMedium),
                        Text('Expires 12/27', style: AppTextStyles.bodySmall),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'Change',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Order summary
              Text('Order Summary', style: AppTextStyles.headlineSmall),
              const SizedBox(height: 12),

              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ...cart.items.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item.quantity}x ${item.menuItem.name}',
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                  Text(
                                    Helpers.formatPrice(item.totalPrice),
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ],
                              ),
                            )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: AppTextStyles.titleMedium),
                            Text(
                              Helpers.formatPrice(cart.total),
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Place order button
              Consumer<OrderProvider>(
                builder: (context, orderProvider, child) {
                  return CustomButton(
                    text: 'Place Order',
                    onPressed: _placeOrder,
                    isLoading: orderProvider.isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrderTypeCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? null
                : Border.all(color: AppColors.divider),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
                size: 28,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
