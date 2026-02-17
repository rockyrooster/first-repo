import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/order_model.dart';
import '../../../providers/order_provider.dart';
import '../../widgets/common/custom_button.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // Simulate order progression for demo purposes
  final List<OrderStatus> _statusFlow = [
    OrderStatus.pending,
    OrderStatus.confirmed,
    OrderStatus.preparing,
    OrderStatus.outForDelivery,
    OrderStatus.delivered,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order', style: AppTextStyles.headlineMedium),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          final order = orderProvider.getOrderById(widget.orderId)
              ?? orderProvider.currentOrder;

          if (order == null) {
            return const Center(child: Text('Order not found'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Order confirmed header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          size: 48,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Order Placed!',
                        style: AppTextStyles.displaySmall.copyWith(
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Order #${order.id.substring(order.id.length - 6)}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textOnPrimary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Estimated time
                      if (order.estimatedDelivery != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Estimated Delivery',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    Helpers.formatTime(order.estimatedDelivery!),
                                    style: AppTextStyles.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Order status tracker
                      Text('Order Status', style: AppTextStyles.headlineSmall),
                      const SizedBox(height: 16),
                      _OrderStatusTracker(
                        currentStatus: order.status,
                        statusFlow: _statusFlow,
                      ),

                      const SizedBox(height: 24),

                      // Order items
                      Text('Order Items', style: AppTextStyles.headlineSmall),
                      const SizedBox(height: 12),
                      ...order.items.map((item) => Padding(
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

                      const Divider(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppTextStyles.titleMedium),
                          Text(
                            Helpers.formatPrice(order.total),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Back to home button
                      CustomButton(
                        text: 'Back to Home',
                        onPressed: () => context.go(AppRoutes.home),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () => context.go(AppRoutes.orderHistory),
                        child: const Text('View Order History'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OrderStatusTracker extends StatelessWidget {
  final OrderStatus currentStatus;
  final List<OrderStatus> statusFlow;

  const _OrderStatusTracker({
    required this.currentStatus,
    required this.statusFlow,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = statusFlow.indexOf(currentStatus);

    return Column(
      children: statusFlow.asMap().entries.map((entry) {
        final index = entry.key;
        final status = entry.value;
        final isCompleted = index <= currentIndex;
        final isCurrent = index == currentIndex;

        return _StatusItem(
          status: status,
          isCompleted: isCompleted,
          isCurrent: isCurrent,
          isLast: index == statusFlow.length - 1,
        );
      }).toList(),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final OrderStatus status;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const _StatusItem({
    required this.status,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.primary : AppColors.surfaceVariant,
                border: isCurrent
                    ? Border.all(color: AppColors.primary, width: 3)
                    : null,
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: AppColors.textOnPrimary)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.primary : AppColors.divider,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status.displayText,
              style: AppTextStyles.titleSmall.copyWith(
                color: isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
            Text(
              status.description,
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
