import 'package:distribution/global.dart';
import 'package:distribution/routes.dart';
import 'package:distribution/src/providers/bottom_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String version = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
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
