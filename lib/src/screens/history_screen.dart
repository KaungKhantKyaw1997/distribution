import 'dart:async';

import 'package:distribution/global.dart';
import 'package:distribution/routes.dart';
import 'package:distribution/src/constants/color_constants.dart';
import 'package:distribution/src/screens/bottombar_screen.dart';
import 'package:distribution/src/services/voucher_service.dart';
import 'package:distribution/src/utils/format_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final voucherService = new VoucherService();
  final storage = FlutterSecureStorage();
  final ScrollController _scrollController = ScrollController();
  TextEditingController search = TextEditingController(text: '');
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List vouchers = [];
  List data = [];
  int page = 1;
  DateTime? startDate = null;
  DateTime? endDate = null;
  TextEditingController dateRange = TextEditingController(text: '');
  List<String> statuslist = [
    "All",
    "Pending",
    "Processing",
    "Shipped",
    "Delivered",
    "Completed",
    "Cancelled",
    "Refunded",
    "Failed",
    "On Hold",
    "Backordered",
    "Returned"
  ];
  String status = "All";
  bool isApply = false;
  String role = "";
  bool _dataLoaded = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    getVocuhers();
  }

  getVocuhers() async {
    try {
      String fromDate = "";
      if (startDate != null) {
        fromDate = DateFormat('yyyy-MM-dd').format(startDate!);
      }

      String toDate = "";
      if (endDate != null) {
        toDate = DateFormat('yyyy-MM-dd').format(endDate!);
      }
      for (int i = 0; i < 200; i++) {
        vouchers.add({
          "date": "2023-01-01",
          "items": [
            {
              "order_id": i + 1,
              "shop_name": "Shop 1",
              "shop_address": "Yangon, Hlaing Township, Ward 1, No 1",
              "shop_latitude": 0.0,
              "shop_longitude": 0.0,
              "distributor_name": "Thant Zin",
              "order_date": "2023-12-26T16:44:38.733091",
              "customer_name": "Customer $i",
              "status": "Delivered",
              "total_amount": (i + 1) * 1000.0,
            },
          ],
        });
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      // final response =
    } catch (e, s) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }
  }

  // _selectDateRange(BuildContext context) async {
  //   return showCustomDateRangePicker(
  //     context,
  //     dismissible: true,
  //     minimumDate: DateTime.now().subtract(Duration(days: 30 * 12 * 1)),
  //     maximumDate: DateTime.now(),
  //     endDate: endDate,
  //     startDate: startDate,
  //     backgroundColor: Colors.white,
  //     primaryColor: Theme.of(context).primaryColor,
  //     onApplyClick: (start, end) {
  //       startDate = start;
  //       endDate = end;
  //       dateRange.text =
  //           '${DateFormat('dd-MM-yyyy').format(startDate!)} - ${DateFormat('dd-MM-yyyy').format(endDate!)}';
  //     },
  //     onCancelClick: () {
  //       startDate = null;
  //       endDate = null;
  //       dateRange.text = '';
  //     },
  //   );
  // }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
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
                            vouchers = [];
                            data = [];
                            page = 1;
                            startDate = null;
                            endDate = null;
                            dateRange.text = "";
                            status = "All";
                            isApply = false;
                            getVocuhers();
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 22,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (!isApply) {
                              startDate = null;
                              endDate = null;
                              dateRange.text = "";
                              status = "All";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 4,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        language["Date Range"] ?? "Date Range",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: TextFormField(
                      controller: dateRange,
                      readOnly: true,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorConstants.fillColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          onPressed: () {
                            // _selectDateRange(context);
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/calendar.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 4,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        language["Status"] ?? "Status",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 24,
                    ),
                    // child: CustomDropDown(
                    //   value: status,
                    //   fillColor: ColorConstants.fillColor,
                    //   onChanged: (newValue) {
                    //     if (newValue != null) {
                    //       setState(() {
                    //         status = newValue;
                    //       });
                    //     }
                    //   },
                    //   items: statuslist,
                    // ),
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
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        vouchers = [];
                        data = [];
                        page = 1;
                        isApply = true;
                        getVocuhers();
                      },
                      child: Text(
                        language["Apply"] ?? "Apply",
                        style: Theme.of(context).textTheme.labelSmall,
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
    String currentDate =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    String yesterdayDate = DateFormat("dd/MM/yyyy")
        .format(DateTime.now().subtract(const Duration(days: 1)))
        .toString();
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
              vouchers = [];
              data = [];
              page = 1;
              getVocuhers();
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
          vouchers = [];
          data = [];
          page = 1;
          await getVocuhers();
        },
        onLoading: () async {
          await getVocuhers();
        },
        child: vouchers.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  width: double.infinity,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: vouchers.length,
                    itemBuilder: (context, index) {
                      String date = vouchers[index]["date"];

                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 4,
                              ),
                              child: Text(
                                currentDate == date
                                    ? "Today"
                                    : yesterdayDate == date
                                        ? "Yesterday"
                                        : date,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            const Divider(
                              height: 0,
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                            ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: vouchers[index]["items"].length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () async {
                                    await Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.voucher_details,
                                      arguments: {
                                        "voucher_id": vouchers[index]["items"]
                                            [i]["voucher_id"],
                                        "shop_name": vouchers[index]["items"][i]
                                            ["shop_name"],
                                        "total_amount": vouchers[index]["items"]
                                            [i]["total_amount"],
                                        "status": vouchers[index]["items"][i]
                                            ["status"],
                                      },
                                      (route) => true,
                                    );

                                    vouchers = [];
                                    data = [];
                                    page = 1;
                                    search.text = '';
                                    startDate = null;
                                    endDate = null;
                                    dateRange.text = '';
                                    role = "";
                                    _dataLoaded = false;
                                    getVocuhers();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 8,
                                          top: 8,
                                        ),
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '#${vouchers[index]["items"][i]["order_id"]}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                ),
                                                Text(
                                                  vouchers[index]["items"][i]
                                                      ["shop_name"],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                // Expanded(
                                                //   child: Text(
                                                //     Jiffy.parseFromDateTime(
                                                //             DateTime.parse(vouchers[index]
                                                //                             [
                                                //                             "items"][i]
                                                //                         [
                                                //                         "created_at"] +
                                                //                     "Z")
                                                //                 .toLocal())
                                                //         .format(
                                                //             pattern: 'hh:mm a'),
                                                //     style: Theme.of(context)
                                                //         .textTheme
                                                //         .headlineLarge,
                                                //   ),
                                                // ),
                                                FormattedAmount(
                                                  amount: double.parse(
                                                      vouchers[index]["items"]
                                                                  [i]
                                                              ["total_amount"]
                                                          .toString()),
                                                  mainTextStyle:
                                                      Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                  decimalTextStyle:
                                                      Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      i < vouchers[index]["items"].length - 1
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                              ),
                                              child: const Divider(
                                                height: 0,
                                                thickness: 0.2,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            : _dataLoaded
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/empty_history.svg",
                          width: 120,
                          height: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                            bottom: 10,
                          ),
                          child: Text(
                            "Empty History",
                            textAlign: TextAlign.center,
                            style: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: Text(
                            "There is no data...",
                            textAlign: TextAlign.center,
                            style: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
      ),
      bottomNavigationBar: const BottomBarScreen(),
    );
  }
}
