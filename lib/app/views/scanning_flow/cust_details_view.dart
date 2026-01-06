import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/cust_details_controller.dart';
import 'package:my_new_app/app/routes/app_routes.dart';
import 'package:my_new_app/app/theme/app_theme.dart';

class CustDetailsView extends GetView<CustDetailsController> {
  const CustDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgLight,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          "Customer Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= VERIFIED BOX ===================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFF5D9B3)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.check_circle, color: Colors.green, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Code Verified",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${controller.discountPercent}% Discount Applied",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= CUSTOMER DETAILS ===================
            const Text(
              "Customer Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(50),
                  //   child: Image.network(
                  //     controller.customerImage,
                  //     width: 60,
                  //     height: 60,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  const SizedBox(width: 16),

                  // Name + Contact
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.customerName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.phone,
                                size: 16, color: Colors.brown),
                            const SizedBox(width: 6),
                            Text(
                              controller.customerPhone,
                              style: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.email,
                                size: 16, color: Colors.brown),
                            const SizedBox(width: 6),
                            Text(
                              controller.customerEmail,
                              style: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= VEHICLE INFO ===================
            const Text(
              "Vehicle Info",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),

            // Vehicle Name
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("VEHICLE"),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7E9D7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.directions_car,
                            color: Colors.brown),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        controller.vehicleName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // License plate
                  _label("LICENSE PLATE"),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.confirmation_number,
                            color: Colors.orange),
                        const SizedBox(width: 12),
                        Text(
                          controller.licensePlate,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Color
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ================= CONFIRM BUTTON ===================
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.selectService,
                  arguments: {
                    "coupon_code": controller.couponCode,
                  },
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.secondaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Confirm & Start Wash",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  // Helper: Label Text
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          letterSpacing: 1.1,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
