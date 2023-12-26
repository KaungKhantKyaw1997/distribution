import 'package:distribution/src/screens/dashboard_screen.dart';
import 'package:distribution/src/screens/history_screen.dart';
import 'package:distribution/src/screens/language_screen.dart';
import 'package:distribution/src/screens/login_screen.dart';
import 'package:distribution/src/screens/order_screen.dart';
import 'package:distribution/src/screens/shop_screen.dart';
import 'package:distribution/src/screens/splash_screen.dart';
import 'package:distribution/src/screens/stock_screen.dart';
import 'package:distribution/src/screens/voucher_detail_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String connection_timeout = "/connection_timeout";
  static const String unauthorized = "/unauthorized";
  static const String splash = '/splash';
  static const String login = '/login';
  static const String shop = '/shop';
  static const String stock = '/stock';
  static const String order = '/order';
  static const String dashboard = '/dashboard';
  static const String history = '/history';
  static const String language = '/language';
  static const String voucher_details = '/voucher_details';
  static final Map<String, WidgetBuilder> routes = {
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => const LogInScreen(),
    shop: (BuildContext context) => const ShopScreen(),
    stock: (BuildContext context) => const StockScreen(),
    order: (BuildContext context) => const OrderScreen(),
    dashboard: (BuildContext context) => const DashboardScreen(),
    history: (BuildContext context) => const HistoryScreen(),
    language: (BuildContext context) => const LanguageScreen(),
    voucher_details: (BuildContext context) => const VoucherDetailScreen(),
  };
}
