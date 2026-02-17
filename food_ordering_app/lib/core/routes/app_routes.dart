/// Route names for the app
class AppRoutes {
  AppRoutes._();

  // Auth Routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main Shell Routes (with bottom nav)
  static const String home = '/';
  static const String menu = '/menu';
  static const String cart = '/cart';
  static const String orderHistory = '/order-history';

  // Full-screen Routes
  static const String search = '/search';
  static const String checkout = '/checkout';
  static const String orderTracking = '/order-tracking/:orderId';
}
