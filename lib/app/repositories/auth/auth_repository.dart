import 'package:dio/dio.dart';
import '../../services/api_service.dart';
import '../../services/endpoints.dart';

class AuthRepository {
  //otp up
  Future<Response> postapipartnerlogin(requestBody) async {
    return await ApiService.post(EndPoints.apipostpartnerlogin, requestBody,
        requireAuthToken: false);
  }

  Future<Response> postapipartnerregister(requestBody) async {
    return await ApiService.post(EndPoints.apipostpartnerregister, requestBody,
        requireAuthToken: false);
  }

  Future<void> partnerLogout() async {
    await ApiService.post(
      EndPoints.apiPostLogout, // ex: partners/logout
      {},
      requireAuthToken: true,
    );
  }

  Future<Response> getPartnerRegistrationStatus(
    String partnerId,
  ) async {
    return await ApiService.get(
      '${EndPoints.apiGetPartnerRegistrationStatus}/$partnerId',
      requireAuthToken: false,
    );
  }

  Future<Response> registerPartnerFcmToken(requestBody) async {
    return await ApiService.put(
      EndPoints.apiPutPartnerFcmToken,
      requestBody,
      requireAuthToken: true,
    );
  }

  Future<Response> savePendingPartnerFcmToken(
    String partnerId,
    String fcmToken,
  ) async {
    return await ApiService.put(
      '${EndPoints.apipostpartnerregister}/$partnerId/fcm-token',
      {
        "fcmToken": fcmToken,
      },
      requireAuthToken: false,
    );
  }
}
