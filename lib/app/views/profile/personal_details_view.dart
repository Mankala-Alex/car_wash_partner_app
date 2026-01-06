import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/config/constants.dart';
import 'package:my_new_app/app/controllers/profile/personal_details_controller.dart';
import 'package:my_new_app/app/theme/app_theme.dart';

class PersonalDetailsView extends GetView<PersonalDetailsController> {
  const PersonalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text(
          "Personal Details",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= IMAGE =================
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  child: controller.bannerImage.value.isEmpty
                      ? Container(
                          height: 200,
                          color: Colors.grey.shade300,
                        )
                      : Image.network(
                          "${Constants.imageBaseUrl}${controller.bannerImage.value}",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.companyName.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          controller.status.value,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _infoRow("Owner Name", controller.ownerName.value),
                      _infoRow("Partner Code", controller.partnerCode.value),
                      _infoRow("City", controller.city.value),
                      _infoRow("District", controller.district.value),
                      _infoRow("Country", controller.country.value),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ================= INFO ROW =================
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
