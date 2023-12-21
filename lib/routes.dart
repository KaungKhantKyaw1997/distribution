import 'package:distribution/src/screens/dashboard_screen.dart';
import 'package:distribution/src/screens/history_screen.dart';
import 'package:distribution/src/screens/language_screen.dart';
import 'package:distribution/src/screens/login_screen.dart';
import 'package:distribution/src/screens/shop_screen.dart';
import 'package:distribution/src/screens/splash_screen.dart';
import 'package:distribution/src/screens/stock_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String shop = '/shop';
  static const String stock = '/stock';
  static const String dashboard = '/dashboard';
  static const String history = '/history';
  static const String language = '/language';

  static final Map<String, WidgetBuilder> routes = {
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => const LogInScreen(),
    shop: (BuildContext context) => const ShopScreen(),
    stock: (BuildContext context) => const StockScreen(),
    dashboard: (BuildContext context) => const DashboardScreen(),
    history: (BuildContext context) => const HistoryScreen(),
    language: (BuildContext context) => const LanguageScreen(),
  };
}
