import 'package:intl/intl.dart';

/// Helper utility functions
class Helpers {
  Helpers._();

  /// Formats price with currency symbol
  static String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Formats date to readable string
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Formats date with time
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy hh:mm a').format(date);
  }

  /// Formats time only
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Calculates estimated delivery time
  static DateTime calculateEstimatedDelivery({
    int preparationMinutes = 20,
    int deliveryMinutes = 30,
  }) {
    return DateTime.now().add(
      Duration(minutes: preparationMinutes + deliveryMinutes),
    );
  }

  /// Truncates text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Capitalizes first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Shows success snackbar
  static void showSuccessMessage(String message) {
    // TODO: Implement with context when needed
    print('Success: $message');
  }

  /// Shows error snackbar
  static void showErrorMessage(String message) {
    // TODO: Implement with context when needed
    print('Error: $message');
  }
}
