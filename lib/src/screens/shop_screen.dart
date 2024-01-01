import 'dart:async';

import 'package:distribution/global.dart';
import 'package:distribution/routes.dart';
import 'package:distribution/src/constants/color_constants.dart';
import 'package:distribution/src/screens/bottombar_screen.dart';
import 'package:distribution/src/screens/drawer_screen.dart';
import 'package:distribution/src/services/api_service.dart';
import 'package:distribution/src/utils/toast.dart';
import 'package:distribution/src/widgets/multi_select_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  TextEditingController search = TextEditingController(text: '');
  FocusNode _searchFocusNode = FocusNode();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List data = [];
  int page = 1;
  Timer? _debounce;
  bool isApply = false;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> selectedDays = [];
  List shops = [];

  @override
  void initState() {
    super.initState();
    getShops();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  getWeekDays() {
    String weekdays = '';

    for (String day in selectedDays) {
      switch (day) {
        case 'Monday':
          weekdays += '1';
          break;
        case 'Tuesday':
          weekdays += '2';
          break;
        case 'Wednesday':
          weekdays += '3';
          break;
        case 'Thursday':
          weekdays += '4';
          break;
        case 'Friday':
          weekdays += '5';
          break;
        case 'Saturday':
          weekdays += '6';
          break;
        case 'Sunday':
          weekdays += '7';
          break;
        default:
          break;
      }
    }

    return weekdays;
  }

  getShops() async {
    try {
      final response = await apiService.get(
        'api/shops',
        params: {
          'page': page,
          'per_page': 10,
          'search': search.text,
          'weekdays': getWeekDays(),
        },
      );
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();

      if (response!["code"] == 200) {
        if (response["data"].isNotEmpty) {
          shops += response["data"];
          page++;
        }
        setState(() {});
      } else {
        ToastUtil.showToast(response["code"], response["message"]);
      }
    } catch (e, s) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }
  }

  shopCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.stock,
          (route) => true,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).primaryColorLight,
              ),
              child: SvgPicture.asset(
                "assets/icons/shop.svg",
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  "${shops[index]["shop_name"]}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            SvgPicture.asset(
              "assets/icons/right-arrow.svg",
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
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
                            getShops();
                          },
                          child: Text(
                            language["Reset"] ?? "Reset",
                            style: TextStyle(
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        language["Days"] ?? "Days",
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
                        getShops();
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
      },
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
                getShops();
              });
            },
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                width: 24,
                height: 24,
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
        drawer: DrawerScreen(),
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
            page = 1;
            shops = [];
            await getShops();
          },
          onLoading: () async {
            await getShops();
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
                itemCount: shops.length,
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
        bottomNavigationBar: BottomBarScreen(),
      ),
    );
  }
}
