import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/menu/menu_screen.dart';
import 'presentation/screens/cart/cart_screen.dart';
import 'presentation/screens/checkout/checkout_screen.dart';
import 'presentation/screens/orders/order_tracking_screen.dart';
import 'presentation/screens/orders/order_history_screen.dart';
import 'presentation/screens/search/search_screen.dart';
import 'presentation/screens/shell/main_shell.dart';

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Food Ordering App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // Shell route with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.menu,
            builder: (context, state) => const MenuScreen(),
          ),
          GoRoute(
            path: AppRoutes.cart,
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: AppRoutes.orderHistory,
            builder: (context, state) => const OrderHistoryScreen(),
          ),
        ],
      ),

      // Auth routes (no bottom nav)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Search (full screen)
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),

      // Checkout (full screen flow)
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),

      // Order tracking
      GoRoute(
        path: '/order-tracking/:orderId',
        builder: (context, state) => OrderTrackingScreen(
          orderId: state.pathParameters['orderId'] ?? '',
        ),
      ),
    ],
  );
}
