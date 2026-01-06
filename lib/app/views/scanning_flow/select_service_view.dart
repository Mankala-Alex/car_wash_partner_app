import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/select_service_controller.dart';
import 'package:my_new_app/app/models/profile/all_services_model.dart';
import 'package:my_new_app/app/routes/app_routes.dart';
import 'package:my_new_app/app/theme/app_theme.dart';

class SelectServiceView extends GetView<SelectServiceController> {
  const SelectServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          "Select Services",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= WASH PACKAGES =================
                    const SizedBox(height: 10),
                    const Text(
                      "Wash Packages",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 15),

                    const Divider(color: AppColors.bgBlackLight, thickness: 1),
                    const SizedBox(height: 15),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.services.isEmpty) {
                        return const Center(
                            child: Text("No services available"));
                      }

                      return Column(
                        children: controller.services.map((service) {
                          final selected =
                              controller.selectedService.value?.id ==
                                  service.id;

                          return _serviceTile(
                            service: service,
                            selected: selected,
                            onTap: () => controller.selectService(service),
                          );
                        }).toList(),
                      );
                    }),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // ================= BOTTOM BAR =================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xfffff3e3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.selectedService.value == null) {
                        Get.snackbar("Select Service",
                            "Please select a service to continue");
                        return;
                      }

                      Get.toNamed(
                        Routes.paymentScreen,
                        arguments: {
                          "coupon_code": controller.couponCode,
                          "partner_id": controller.partnerId, // ✅ ADD THIS
                          "service": controller.selectedService.value,
                          "original_amount": controller.originalPrice,
                          "final_amount": controller.totalAfterDiscount,
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Confirm Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // COST BREAKDOWN BOX
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.bgLightSecondaryLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cost Breakdown",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Original Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Original Price"),
                            Text(
                              "\$${controller.originalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Discount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.local_offer,
                                    size: 18, color: AppColors.blue),
                                SizedBox(width: 6),
                                Text("Partner Discount"),
                              ],
                            ),
                            Text(
                              "-${controller.discountPercent}%",
                              style: const TextStyle(
                                  color: AppColors.successLight),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Total
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total to Pay",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Text(
                              "\$ ${controller.totalAfterDiscount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: AppColors.successLight,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Discount automatically applied for QR code customers.",
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  // ================= PACKAGE TILE =================
  Widget _serviceTile({
    required AllServicesModel service,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xfffff7ed) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.secondaryLight : AppColors.borderGray,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // LEFT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.serviceName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                if (service.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      service.description!,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  ),
              ],
            ),

            // RIGHT
            Row(
              children: [
                Text(
                  "₹${service.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(width: 8),
                if (selected)
                  const Icon(Icons.check_circle, color: Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
