import 'package:distribution/global.dart';
import 'package:distribution/src/utils/format_amount.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = ScrollController();
  List orders = [
    {
      "name": "Deleaf Moisturizing Gel Pomegrat e Sachet 6g",
      "quantity": 5,
      "unit": "PCS",
      "pricing_price": 1000,
      "price": 1000,
      "discount": 0,
    },
    {
      "name": "Cute Press 1-2 Beautiful Airy Matte Liquid foundation 03 Sand",
      "quantity": 10,
      "unit": "CT",
      "pricing_price": 1000,
      "price": 5000,
      "discount": 0,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showOrderBottomSheet(BuildContext contex, index) {
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        orders[index]["name"].toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FormattedAmount(
                            amount: double.parse(
                                orders[index]["pricing_price"].toString()),
                            mainTextStyle:
                                Theme.of(context).textTheme.labelLarge,
                            decimalTextStyle:
                                Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        FormattedAmount(
                          amount:
                              double.parse(orders[index]["price"].toString()),
                          mainTextStyle: Theme.of(context).textTheme.labelLarge,
                          decimalTextStyle:
                              Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Theme.of(context).primaryColorLight,
                          child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (orders[index]['quantity'] > 1) {
                                orders[index]['quantity']--;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Text(
                            orders[index]['quantity'].toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Theme.of(context).primaryColorLight,
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              orders[index]['quantity']++;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
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

  orderCard(index) {
    return GestureDetector(
      onTap: () {
        _showOrderBottomSheet(context, index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColorLight,
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    orders[index]["name"].toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                  ),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Text(
                      '${orders[index]["quantity"]}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FormattedAmount(
                    amount:
                        double.parse(orders[index]["pricing_price"].toString()),
                    mainTextStyle: Theme.of(context).textTheme.labelLarge,
                    decimalTextStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                FormattedAmount(
                  amount: double.parse(orders[index]["price"].toString()),
                  mainTextStyle: Theme.of(context).textTheme.labelLarge,
                  decimalTextStyle: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          language["Order"] ?? "Order",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: orders.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 100,
              crossAxisSpacing: 8,
              crossAxisCount: 1,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return orderCard(index);
            },
          ),
        ),
      ),
    );
  }
}
