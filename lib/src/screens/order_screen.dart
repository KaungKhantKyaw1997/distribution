import 'package:distribution/global.dart';
import 'package:distribution/src/screens/bottombar_screen.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            language["Order"] ?? "Order",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      bottomNavigationBar: const BottomBarScreen(),
    );
  }
}
