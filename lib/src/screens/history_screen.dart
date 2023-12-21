import 'dart:async';

import 'package:distribution/global.dart';
import 'package:distribution/src/constants/color_constants.dart';
import 'package:distribution/src/screens/bottombar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController search = TextEditingController(text: '');
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List data = [];
  int page = 1;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: TextField(
          controller: search,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          style: Theme.of(context).textTheme.bodyLarge,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: language["Search"] ?? "Search",
            filled: true,
            fillColor: ColorConstants.fillColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            _debounce?.cancel();
            _debounce = Timer(Duration(milliseconds: 300), () {
              data = [];
              page = 1;
            });
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/filter.svg",
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarScreen(),
    );
  }
}
