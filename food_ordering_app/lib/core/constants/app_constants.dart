/// App-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Food Ordering App';
  static const String appVersion = '1.0.0';

  // API & Firebase
  static const int requestTimeout = 30; // seconds

  // Pagination
  static const int pageSize = 20;
  static const int maxSearchResults = 50;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardElevation = 2.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Image Sizes
  static const double menuItemImageHeight = 200.0;
  static const double menuItemThumbnailSize = 80.0;
  static const double categoryImageSize = 100.0;

  // Price Display
  static const String currencySymbol = '\$';
  static const int priceDecimalPlaces = 2;

  // Order Status Display Times
  static const Duration orderStatusRefreshInterval = Duration(seconds: 10);

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;

  // Search
  static const int minSearchQueryLength = 2;
  static const Duration searchDebounceDelay = Duration(milliseconds: 500);
}
