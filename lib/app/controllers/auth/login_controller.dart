import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:car_wash_partner/app/helpers/flutter_toast.dart';
import 'package:car_wash_partner/app/helpers/shared_preferences.dart';
import 'package:car_wash_partner/app/helpers/secure_store.dart';
import 'package:car_wash_partner/app/repositories/auth/auth_repository.dart';
import 'package:car_wash_partner/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  // ✅ REQUIRED
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  Future<void> loginPartner() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      errorToast("Username & password required");
      return;
    }

    try {
      isLoading.value = true;

      final resp = await _repo.postapipartnerlogin({
        "username": username,
        "password": password,
      });

      if (resp.data["success"] == true) {
        final partner = resp.data["partner"];
        final token = resp.data["token"] ?? "";

        // Store partner info in SharedPrefs
        await SharedPrefsHelper.setString("partnerId", partner["id"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerCompanyName", partner["company_name"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerCode", partner["partner_code"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerOwnerName", partner["owner_name"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerImage", partner["image_url"] ?? "");
        await SharedPrefsHelper.setString("partnerCity", partner["city"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerDistrict", partner["district"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerCountry", partner["country"] ?? "");

        // Store token in secure storage (FlutterSecureStore)
        // This is where the API service looks for the token
        await FlutterSecureStore()
            .storeSingleValue(SharedPrefsHelper.accessToken, token);

        successToast("Login successful!");
        Get.offAllNamed(Routes.dashboard);
      } else {
        final errorMsg = resp.data["message"] ?? "Invalid credentials";
        errorToast(errorMsg);
      }
    } on DioException catch (e) {
      final errorMsg =
          e.response?.data["message"] ?? e.message ?? "Login failed";
      errorToast(errorMsg);
    } catch (e) {
      errorToast("An unexpected error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
