import 'package:dio/dio.dart';
import '../../services/api_service.dart';
import '../../services/endpoints.dart';

class ProfileRepository {
  //otp up
  Future<Response> getPartnerServices(String partnerId) async {
    return await ApiService.get(
      "${EndPoints.apigetPartnerServices}/$partnerId/services",
      requireAuthToken: true,
    );
  }

  Future<Response> addPartnerService(
    String partnerId,
    Map<String, dynamic> body,
  ) async {
    return await ApiService.post(
      "${EndPoints.apigetPartnerServices}/$partnerId/services",
      body,
      requireAuthToken: true,
    );
  }

  Future<Response> editService(
    String partnerId,
    String serviceId,
    Map<String, dynamic> body,
  ) async {
    return await ApiService.put(
      "/partners/$partnerId/services/$serviceId",
      body,
      requireAuthToken: true,
    );
  }

  Future<Response> deleteService(
    String partnerId,
    String serviceId,
  ) async {
    return await ApiService.delete(
      "/partners/$partnerId/services/$serviceId",
      requireAuthToken: true,
    );
  }

  Future<Response> changePartnerPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await ApiService.post(
      EndPoints.apiPostChangePassword,
      {
        "current_password": currentPassword,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
      },
      requireAuthToken: true, // ✅ MUST BE TRUE
    );
  }
}
