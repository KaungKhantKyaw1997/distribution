import 'package:distribution/global.dart';
import 'package:distribution/routes.dart';
import 'package:distribution/src/constants/color_constants.dart';
import 'package:distribution/src/providers/bottom_provider.dart';
import 'package:distribution/src/screens/bottombar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  String version = '';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    getData();
  }

  getData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: ColorConstants.fillColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ),
      drawer: buildDrawer(),
      body: GestureDetector(
        onTap: () {
          if (_animationController.isCompleted) {
            _animationController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(250 * _animation.value, 0),
              child: child,
            );
          },
          child: Container(),
        ),
      ),
      bottomNavigationBar: const BottomBarScreen(),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                language["General"] ?? "General",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.language,
                (route) => true,
              );
              BottomProvider bottomProvider =
                  Provider.of<BottomProvider>(context, listen: false);
              bottomProvider.selectIndex(bottomProvider.currentIndex);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/global.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: language["Language"] ?? "Language",
                              style: Theme.of(context).textTheme.labelLarge,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Text(
                      selectedLangIndex == 0 ? "English" : "မြန်မာ",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                language["Help & Support"] ?? "Help & Support",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      top: 16,
                      bottom: 16,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/version.svg",
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: language["App Version"] ?? "App Version",
                              style: Theme.of(context).textTheme.labelLarge,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5,
                      top: 16,
                      bottom: 16,
                    ),
                    child: Text(
                      'v$version',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 32,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/log-out.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                            top: 16,
                            bottom: 16,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: language["Log Out"] ?? "Log Out",
                                  style: Theme.of(context).textTheme.labelLarge,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
