import 'package:dio/dio.dart';
import '../../services/api_service.dart';
import '../../services/endpoints.dart';

class ScanningRepository {
  //otp up
  Future<Response> postValidateCoupon(requestBody) async {
    return await ApiService.post(EndPoints.apipostvalidatecoupon, requestBody,
        requireAuthToken: true);
  }

  Future<Response> getPartnerCouponDetails(String couponCode) async {
    return await ApiService.get(
      "${EndPoints.apigetcustomerdetails}?coupon_code=$couponCode",
      requireAuthToken: true,
    );
  }

  Future<Response> postRedeemCoupon(Map<String, dynamic> body) async {
    return await ApiService.post(
      EndPoints.apipostredeemcoupon,
      body,
      requireAuthToken: true,
    );
  }

  Future<Response> getPartnerHistory(
    String partnerId, {
    int? month,
    int? year,
  }) async {
    final Map<String, dynamic> query = {};
    if (month != null) query['month'] = month;
    if (year != null) query['year'] = year;

    return await ApiService.get(
      "${EndPoints.apigetPartnerServiceHistory}/$partnerId/history",
      queryParameters: query.isEmpty ? null : query,
      requireAuthToken: true,
    );
  }
}
