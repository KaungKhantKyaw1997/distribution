import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VoucherService {
  final storage = FlutterSecureStorage();
  final Dio dio = Dio();
  CancelToken _cancelToken = CancelToken();
  // Future<Map<String, dynamic>?> getVouchersData({
  //   int page = 1,
  //   int perPage = 10,
  //   String fromDate = '',
  //   String toDate = '',
  //   double fromAmount = 0.0,
  //   double toAmount = 0.0,
  //   String search = '',
  //   String status = 'All',
  // }) async {
  //   var token = await storage.read(key: "token") ?? '';
  //   var url =
  //       '${ApiConstants.ordersUrl}?page=$page&per_page=$perPage&search=$search';
  //   if (fromDate.isNotEmpty) url += '&from_date=$fromDate';
  //   if (toDate.isNotEmpty) url += '&to_date=$toDate';
  //   if (toAmount != 0.0) url += '&from_amount=$fromAmount';
  //   if (toAmount != 0.0) url += '&to_amount=$toAmount';
  //   if (status != 'All') url += '&status=$status';

  //   final response = await dio.get(
  //     url,
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         if (token.isNotEmpty) 'Authorization': 'Bearer $token',
  //       },
  //     ),
  //     cancelToken: _cancelToken,
  //   );

  //   return response.data;
  // }
}
