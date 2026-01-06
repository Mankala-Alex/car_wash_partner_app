import 'package:dio/dio.dart';
import '../../services/api_service.dart';
import '../../services/endpoints.dart';

class AuthRepository {
  //otp up
  Future<Response> postapipartnerlogin(requestBody) async {
    return await ApiService.post(EndPoints.apipostpartnerlogin, requestBody,
        requireAuthToken: false);
  }

  Future<void> partnerLogout() async {
    await ApiService.post(
      EndPoints.apiPostLogout, // ex: partners/logout
      {},
      requireAuthToken: true,
    );
  }
}
