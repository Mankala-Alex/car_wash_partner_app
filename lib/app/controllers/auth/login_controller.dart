import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/helpers/flutter_toast.dart';
import 'package:my_new_app/app/helpers/shared_preferences.dart';
import 'package:my_new_app/app/repositories/auth/auth_repository.dart';
import 'package:my_new_app/app/routes/app_routes.dart';

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

        await SharedPrefsHelper.setString("partnerId", partner["id"]);
        await SharedPrefsHelper.setString(
            "partnerCompanyName", partner["company_name"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerCode", partner["partner_code"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerOwnerName", partner["owner_name"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerImage", partner["image_url"] ?? "");
        await SharedPrefsHelper.setString("partnerToken", resp.data["token"]);
        await SharedPrefsHelper.setString("partnerCity", partner["city"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerDistrict", partner["district"] ?? "");
        await SharedPrefsHelper.setString(
            "partnerCountry", partner["country"] ?? "");
        Get.offAllNamed(Routes.dashboard);
      } else {
        Get.snackbar("Login Failed", "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed");
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
