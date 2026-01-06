import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/confirmation_screen_controller.dart';
import 'package:my_new_app/app/routes/app_routes.dart';

class ConfirmationScreenView extends GetView<ConfirmationScreenController> {
  const ConfirmationScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Service Confirmation",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ---------------- SUCCESS ICON ----------------
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 120,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Service Completed!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "The transaction has been processed\nsuccessfully for ticket #992-A.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 30),

            // ---------------- CUSTOMER CARD ----------------
            _infoCard(
              title: "CUSTOMER",
              name: controller.customerName,
              icon: Icons.person,
              iconColor: Colors.blue,
            ),

            const SizedBox(height: 14),

            // ---------------- VEHICLE CARD ----------------
            _infoCard(
              title: "VEHICLE",
              name: controller.vehicleInfo,
              subtitle: "Silver • XYZ-8821",
              icon: Icons.directions_car,
              iconColor: Colors.orange,
            ),

            const SizedBox(height: 25),

            // ---------------- ORDER SUMMARY ----------------
            _summaryCard(),

            const SizedBox(height: 30),

            // ---------------- RETURN BUTTON ----------------

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.dashboard);
                },
                child: const Text(
                  "Cash Collected",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // CUSTOMER & VEHICLE CARD
  // ---------------------------------------------------------
  Widget _infoCard({
    required String title,
    required String name,
    String? subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: iconColor.withOpacity(0.15),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // ORDER SUMMARY CARD
  // ---------------------------------------------------------
  Widget _summaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "PAID",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 18),

          _summaryRow("Deluxe Wash Package", "\$20.00"),
          const SizedBox(height: 12),
          _summaryRow("Interior Vacuum", "\$5.00"),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 15, color: Colors.black87)),
        Text(price,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
