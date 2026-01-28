import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_partner/app/helpers/flutter_toast.dart';
import 'package:car_wash_partner/app/repositories/profile/profile_repostory.dart';

class ChangePasswordController extends GetxController {
  final ProfileRepository repository = ProfileRepository();

  // Text controllers
  final currentPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  // Loading
  final isLoading = false.obs;

  // Show / Hide password
  final showCurrent = false.obs;
  final showNew = false.obs;
  final showConfirm = false.obs;

  // ================= VALIDATION =================
  bool validate() {
    if (currentPasswordCtrl.text.isEmpty ||
        newPasswordCtrl.text.isEmpty ||
        confirmPasswordCtrl.text.isEmpty) {
      errorToast("All fields are required");
      return false;
    }

    if (newPasswordCtrl.text.length < 6) {
      errorToast("New password must be at least 6 characters");
      return false;
    }

    if (currentPasswordCtrl.text == newPasswordCtrl.text) {
      errorToast("New password must be different from current password");
      return false;
    }

    if (newPasswordCtrl.text != confirmPasswordCtrl.text) {
      errorToast("Passwords do not match");
      return false;
    }

    return true;
  }

  // ================= CHANGE PASSWORD =================
  Future<void> changePassword() async {
    if (!validate()) return;

    try {
      isLoading.value = true;

      final resp = await repository.changePartnerPassword(
        currentPassword: currentPasswordCtrl.text,
        newPassword: newPasswordCtrl.text,
        confirmPassword: confirmPasswordCtrl.text,
      );

      if (resp.data['success'] == true) {
        successToast(resp.data['message'] ?? "Password updated");
        Get.back(); // go back after success
      } else {
        errorToast(resp.data['message'] ?? "Failed to change password");
      }
    } catch (e) {
      errorToast("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }
}
