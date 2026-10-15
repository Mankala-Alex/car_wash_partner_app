import 'package:car_wash_partner/app/controllers/auth/registartion_pending_controller.dart';
import 'package:car_wash_partner/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPendingView extends GetView<RegistartionPendingController> {
  const RegistrationPendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.hourglass_top_rounded,
                  size: 80,
                  color: AppColors.secondaryLight,
                ),
                const SizedBox(height: 24),
                Text(
                  'waiting_for_approval'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'registration_pending_message'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.goToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryLight,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('login'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
