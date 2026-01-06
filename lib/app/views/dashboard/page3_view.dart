import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/config/constants.dart';
import 'package:my_new_app/app/custome_widgets/custome_confirmation_dialog.dart';
import 'package:my_new_app/app/routes/app_routes.dart';
import 'package:my_new_app/app/theme/app_theme.dart';
import '../../controllers/dashboard/dashboard_controller.dart';

class Page3View extends GetView<DashboardController> {
  const Page3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= BANNER IMAGE =================
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Obx(() {
                if (controller.bannerImage.value.isEmpty) {
                  return Container(color: Colors.grey.shade300);
                }
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    "${Constants.imageBaseUrl}${controller.bannerImage.value}",
                    fit: BoxFit.cover,
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // ================= PARTNER DETAILS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Partner + Code row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "PARTNER",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Obx(() => Text(
                            controller.partnerCode.value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          )),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Company Name
                  Obx(() => Text(
                        controller.companyName.value,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),

                  const SizedBox(height: 6),

                  // Status
                  Obx(() => Text(
                        "Owner: ${controller.ownerName.value}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ================= ACCOUNT SETTINGS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ACCOUNT SETTINGS",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _settingsTile(
                    icon: Icons.person,
                    title: "Personal Details",
                    subtitle: "Edit profile information",
                    onTap: () {
                      Get.toNamed(Routes.personalDetails);
                    },
                  ),
                  _settingsTile(
                    icon: Icons.add,
                    title: "Add Services",
                    subtitle: "Add or remove services offered",
                    onTap: () {
                      Get.toNamed(Routes.allservices);
                    },
                  ),
                  _settingsTile(
                    icon: Icons.lock,
                    title: "Change Password",
                    subtitle: "Update security credentials",
                    onTap: () {
                      Get.toNamed(Routes.changePassword);
                    },
                  ),
                  _settingsTile(
                    icon: Icons.language,
                    title: "Change Language",
                    subtitle: "English (US)",
                    onTap: () {
                      Get.toNamed(Routes.langchange);
                    },
                  ),
                  _settingsTile(
                    icon: Icons.logout,
                    title: "Log Out",
                    subtitle: "Sign out of your account",
                    isLogout: true,
                    onTap: () {
                      Get.dialog(
                        CustomConfirmationDialog(
                          header: "Logout",
                          body: "Are you sure you want to logout?",
                          yesText: "Logout",
                          noText: "Cancel",
                          onYes: () {
                            Get.back(); // close dialog
                            controller.logout(); // actual logout
                          },
                          onNo: () {
                            Get.back(); // just close dialog
                          },
                        ),
                        barrierDismissible: false,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= SETTINGS TILE =================
  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? AppColors.errorLight : AppColors.secondaryLight,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
