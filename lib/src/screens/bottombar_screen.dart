import 'package:distribution/global.dart';
import 'package:distribution/src/providers/bottom_provider.dart';
import 'package:distribution/src/screens/dashboard_screen.dart';
import 'package:distribution/src/screens/history_screen.dart';
import 'package:distribution/src/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List navItems = [
    {"index": 0, "icon": "assets/icons/order.svg", "label": "Order"},
    {"index": 1, "icon": "assets/icons/pie-chart.svg", "label": "Dashboard"},
    {"index": 2, "icon": "assets/icons/history.svg", "label": "History"},
  ];

  Future<void> _onTabSelected(int index) async {
    BottomProvider bottomProvider =
        Provider.of<BottomProvider>(context, listen: false);

    if (bottomProvider.currentIndex != index) {
      bottomProvider.selectIndex(index);

      var data = navItems[index];
      if (data["label"] == 'Order') {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return OrderScreen();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return child;
            },
            transitionDuration: Duration(seconds: 0),
          ),
          (route) => false,
        );
      } else if (data["label"] == 'Dashboard') {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return DashboardScreen();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return child;
            },
            transitionDuration: Duration(seconds: 0),
          ),
          (route) => false,
        );
      } else if (data["label"] == 'History') {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return HistoryScreen();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return child;
            },
            transitionDuration: Duration(seconds: 0),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomProvider>(builder: (context, bottomProvider, child) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          currentIndex: bottomProvider.currentIndex,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
          onTap: _onTabSelected,
          items: navItems.map((navItem) {
            return BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: 8,
                ),
                child: SvgPicture.asset(
                  navItem["icon"],
                  colorFilter: ColorFilter.mode(
                    navItem["index"] == bottomProvider.currentIndex
                        ? Theme.of(context).primaryColorDark
                        : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: language[navItem["label"]] ?? navItem["label"],
            );
          }).toList(),
        ),
      );
    });
  }
}
