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

    if (username.isEmpty) {
      errorToast("user_id_is_required".tr);
      return;
    }

    if (password.isEmpty) {
      errorToast("password_is_required".tr);
      return;
    }

    try {
      final response = await _repo.postapipartnerlogin({
        "username": username,
        "password": password,
      });

      if (response.data["success"] == true) {
        final partner = response.data["partner"];
        final token = response.data["token"];

        await SharedPrefsHelper.setString("partnerId", partner["id"] ?? "");

        await FlutterSecureStore().storeSingleValue(
          SharedPrefsHelper.accessToken,
          token,
        );

        Get.offAllNamed(Routes.dashboard);
      }
    } on DioException catch (e) {
      errorToast(
        e.response?.data["error"] ?? "invalid_credentials".tr,
      );
    }
  }

  // @override
  // void onClose() {
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
