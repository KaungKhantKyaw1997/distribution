import 'dart:async';

import 'package:distribution/global.dart';
import 'package:distribution/routes.dart';
import 'package:distribution/src/constants/color_constants.dart';
import 'package:distribution/src/widgets/multi_select_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController search = TextEditingController(text: '');
  FocusNode _searchFocusNode = FocusNode();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List data = [];
  int page = 1;
  Timer? _debounce;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> selectedDays = [];

  List stocks = [
    {
      "name": "Stock 1",
      "selected": false,
    },
    {
      "name": "Stock 2",
      "selected": false,
    },
    {
      "name": "Stock 3",
      "selected": false,
    },
    {
      "name": "Stock 4",
      "selected": false,
    },
    {
      "name": "Stock 5",
      "selected": false,
    },
    {
      "name": "Stock 6",
      "selected": false,
    },
    {
      "name": "Stock 7",
      "selected": false,
    },
    {
      "name": "Stock 8",
      "selected": false,
    },
    {
      "name": "Stock 9",
      "selected": false,
    },
    {
      "name": "Stock 10",
      "selected": false,
    }
  ];
  int selectedCount = 0;
  bool isApply = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            top: 70,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        selectedDays = [];
                        data = [];
                        page = 1;
                        isApply = false;
                        setState(() {});
                      },
                      child: Text(
                        language["Reset"] ?? "Reset",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      language["Filters"] ?? "Filters",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (!isApply) {
                          selectedDays = [];
                          setState(() {});
                        }
                      },
                      child: Text(
                        language["Close"] ?? "Close",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 8,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  language["Categories"] ?? "Categories",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                              ),
                              child: MultiSelectChip(
                                days,
                                selectedDays,
                                onSelectionChanged: (selectedList) {
                                  setState(() {
                                    selectedDays = selectedList;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                                left: 16,
                                right: 16,
                                bottom: 8,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  language["Brands"] ?? "Brands",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              child: MultiSelectChip(
                                days,
                                selectedDays,
                                onSelectionChanged: (selectedList) {
                                  setState(() {
                                    selectedDays = selectedList;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Divider(
                  height: 0,
                  color: Colors.grey,
                  thickness: 0.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    data = [];
                    page = 1;
                    isApply = true;
                  },
                  child: Text(
                    language["Apply"] ?? "Apply",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  shopCard(index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          stocks[index]["selected"] = !stocks[index]["selected"];
          selectedCount =
              stocks.where((shop) => shop['selected'] == true).length;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: stocks[index]["selected"]
              ? Theme.of(context).primaryColorLight
              : Colors.white,
          border: Border.all(
            color: stocks[index]["selected"]
                ? Theme.of(context).primaryColor
                : Colors.white,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: stocks[index]["selected"]
                    ? Colors.white
                    : Theme.of(context).primaryColorLight,
              ),
              child: SvgPicture.asset(
                "assets/icons/stock.svg",
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                child: Text(
                  "${stocks[index]["name"]}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                border: Border.all(
                  color: stocks[index]["selected"]
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  width: 1.0,
                ),
              ),
              child: stocks[index]["selected"]
                  ? SvgPicture.asset(
                      "assets/icons/check.svg",
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _searchFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: TextField(
            controller: search,
            focusNode: _searchFocusNode,
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
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              prefixIcon: IconButton(
                onPressed: null,
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  colorFilter: ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
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
              onPressed: () {
                _showFilterBottomSheet(context);
              },
            ),
          ],
        ),
        body: SmartRefresher(
          header: WaterDropMaterialHeader(
            backgroundColor: Theme.of(context).primaryColor,
            color: Colors.white,
          ),
          footer: ClassicFooter(),
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            _refreshController.loadComplete();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: stocks.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 90,
                  crossAxisSpacing: 8,
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return shopCard(index);
                },
              ),
            ),
          ),
        ),
        floatingActionButton: selectedCount > 0
            ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                width: double.infinity,
                child: FloatingActionButton(
                  elevation: 0.1,
                  backgroundColor: Theme.of(context).primaryColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.order,
                      (route) => true,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stocks: ${selectedCount}",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/right-arrow.svg",
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
