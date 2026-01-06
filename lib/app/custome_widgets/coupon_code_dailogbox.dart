import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/theme/app_theme.dart';

class CouponCodeDailogbox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const CouponCodeDailogbox({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bgLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 26),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              "Enter QR Code",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 14),

            // Text Field
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter code manually",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryLight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
