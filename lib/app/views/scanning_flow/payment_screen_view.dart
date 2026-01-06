import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/payment_screen_controller.dart';
import 'package:my_new_app/app/theme/app_theme.dart' hide AppColors;

class PaymentScreenView extends GetView<PaymentScreenController> {
  const PaymentScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.of(context).bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomTheme.of(context).bgColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: Get.back,
        ),
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Car info card

            const SizedBox(height: 20),

            // Scan card with icon instead of QR
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text(
                    'Scan to complete payment',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: CustomTheme.of(context).secondaryColor,
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.payment, // any icon instead of QR
                        size: 72,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_tethering, size: 16, color: Colors.blue),
                      SizedBox(width: 6),
                      Text(
                        'Waiting for scan...',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Amount card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'TOTAL AMOUNT DUE',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 1.5,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff1E88E5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          controller.finalAmount.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 34,
                            color: Color(0xffFF9800),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xfffff3e0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "\$${controller.originalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text('•',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                          const SizedBox(width: 6),
                          Text(
                            "${((1 - (controller.finalAmount / controller.originalAmount)) * 100).round()}% DISCOUNT",
                            style: const TextStyle(
                              color: Color(0xffFF9800),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Service Breakdown',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.circle, size: 6, color: Colors.blueGrey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          controller.service.serviceName,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        "\$${controller.originalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom buttons
            Row(
              children: [
                // const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.redeemAndContinue,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: CustomTheme.of(context).secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Done',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.check, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
