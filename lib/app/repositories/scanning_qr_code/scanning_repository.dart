import 'package:dio/dio.dart';
import '../../services/api_service.dart';
import '../../services/endpoints.dart';

class ScanningRepository {
  //otp up
  Future<Response> postValidateCoupon(requestBody) async {
    return await ApiService.post(EndPoints.apipostvalidatecoupon, requestBody,
        requireAuthToken: false);
  }

  Future<Response> getPartnerCouponDetails(String couponCode) async {
    return await ApiService.get(
      "${EndPoints.apigetcustomerdetails}?coupon_code=$couponCode",
      requireAuthToken: false,
    );
  }

  Future<Response> postRedeemCoupon(Map<String, dynamic> body) async {
    return await ApiService.post(
      EndPoints.apipostredeemcoupon,
      body,
      requireAuthToken: false,
    );
  }

  Future<Response> getPartnerHistory(String partnerId) async {
    return await ApiService.get(
      "${EndPoints.apigetPartnerServiceHistory}/$partnerId/history",
      requireAuthToken: false,
    );
  }
}
