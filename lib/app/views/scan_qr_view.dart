import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:car_wash_partner/app/controllers/scan_qr_controller.dart';
import 'package:car_wash_partner/app/theme/app_theme.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ---------------- CAMERA PREVIEW ----------------
          MobileScanner(
            controller: controller.cameraController,
            fit: BoxFit.cover,
            onDetect: controller.onDetect,
          ),

          // Slight dark overlay
          Container(color: Colors.black.withOpacity(0.25)),

          // ---------------- TOP BAR ----------------
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circleButton(
                  Icons.close,
                  () {
                    controller.stopCamera();
                    Get.back();
                  },
                ),
                const Text(
                  "Scan QR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 40), // (empty to balance layout)
              ],
            ),
          ),

          // ---------------- INSTRUCTION TEXT ----------------
          const Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Align QR code inside the frame",
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
          ),

          // ---------------- SCAN FRAME ----------------
          _scanFrame(context),

          // ---------------- SUCCESS CARD ----------------
          _successCard(),

          // ---------------- MANUAL ENTRY BUTTON ----------------
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: controller.showCouponCodeDailogbox,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white30),
                  color: Colors.white10,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Enter Code Manually",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ROUND BUTTON (TOP LEFT) ----------------
  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white24,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  // ---------------- SCAN FRAME UI ----------------
  Widget _scanFrame(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.75;

    return Positioned.fill(
      child: Center(
        child: Obx(() {
          return SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Frame background
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white70, width: 2),
                  ),
                ),

                // Animated scan line
                if (!controller.scanned.value)
                  Positioned(
                    top: size * controller.scanLinePosition.value,
                    child: Container(
                      width: size,
                      height: 3,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.secondaryLight,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                // Success check mark
                if (controller.scanned.value)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child:
                        const Icon(Icons.check, color: Colors.white, size: 45),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------- SUCCESS CARD ----------------
  Widget _successCard() {
    return Obx(() {
      if (!controller.scanned.value || controller.isLoading.value) {
        return const SizedBox();
      }

      return Positioned(
        bottom: 140,
        left: 20,
        right: 20,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.verified, color: Colors.green, size: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  controller.scannedCode.value,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.person, size: 26),
            ],
          ),
        ),
      );
    });
  }
}
