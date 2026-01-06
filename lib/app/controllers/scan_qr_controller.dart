import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:my_new_app/app/custome_widgets/coupon_code_dailogbox.dart';
import 'package:my_new_app/app/helpers/flutter_toast.dart';
import 'package:my_new_app/app/models/scanning_flow/validate_coupon_model.dart';
import 'package:my_new_app/app/repositories/scanning_qr_code/scanning_repository.dart';
import 'package:my_new_app/app/routes/app_routes.dart';

class ScanQrController extends GetxController {
  final ScanningRepository repository = ScanningRepository();

  TextEditingController codeCtrl = TextEditingController();

  final MobileScannerController cameraController = MobileScannerController();

  var scanned = false.obs;
  var isLoading = false.obs;
  var scannedCode = "".obs;

  // 🔹 SCAN LINE ANIMATION
  var scanLinePosition = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _animateScanLine();
  }

  void _animateScanLine() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 12));
      if (!scanned.value) {
        scanLinePosition.value += 0.01;
        if (scanLinePosition.value >= 1) scanLinePosition.value = 0;
      }
      return true;
    });
  }

  void showCouponCodeDailogbox() {
    Get.dialog(
      CouponCodeDailogbox(
        controller: codeCtrl,
        onSubmit: () {
          if (codeCtrl.text.trim().isEmpty) {
            errorToast("Please enter a valid code");
            return;
          }

          Get.back(); // close dialog

          validateCoupon(codeCtrl.text.trim()); // 🔥 THIS WAS MISSING
        },
      ),
      barrierDismissible: false,
    );
  }

  // ================= SCAN RESULT =================
  void onDetect(BarcodeCapture capture) async {
    if (scanned.value) return;

    final code = capture.barcodes.first.rawValue ?? "";
    scannedCode.value = code;
    if (code.isEmpty) {
      errorToast("Invalid QR Code");
      return;
    }

    scanned.value = true;
    cameraController.stop();

    await validateCoupon(code);
  }

  // ================= VALIDATE API =================
  Future<void> validateCoupon(String couponCode) async {
    try {
      isLoading.value = true;

      // 1️⃣ VALIDATE
      final validateResp = await repository.postValidateCoupon({
        "coupon_code": couponCode,
      });

      final validateModel = ValidateCouponModel.fromJson(validateResp.data);

      if (!validateModel.success || validateModel.data == null) {
        errorToast("Invalid coupon");
        resetScanner();
        return;
      }

      // 2️⃣ FETCH FULL DETAILS
      final detailsResp = await repository.getPartnerCouponDetails(couponCode);

      final detailsData = detailsResp.data['data'];

      if (detailsData == null) {
        errorToast("Failed to load details");
        resetScanner();
        return;
      }

      // 3️⃣ NAVIGATE WITH FULL DATA
      Get.offNamed(
        Routes.custDetails,
        arguments: detailsData,
      );
    } catch (e) {
      errorToast("Validation failed");
      resetScanner();
    } finally {
      isLoading.value = false;
    }
  }

  void resetScanner() {
    scanned.value = false;
    cameraController.start();
  }

  void stopCamera() {
    cameraController.stop();
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:my_new_app/app/custome_widgets/coupon_code_dailogbox.dart';
// import 'package:my_new_app/app/helpers/flutter_toast.dart';
// import 'package:my_new_app/app/routes/app_routes.dart';

// class ScanQrController extends GetxController {
//   // CAMERA CONTROLLER
//   final MobileScannerController cameraController = MobileScannerController();
//   TextEditingController codeCtrl = TextEditingController();
//   // SCAN STATE
//   var scanned = false.obs;
//   var scannedCode = "".obs;

//   // ANIMATED SCAN BAR POSITION (0 → top, 1 → bottom)
//   var scanLinePosition = 0.0.obs;

//   // Start scan animation
//   @override
//   void onInit() {
//     super.onInit();
//     _animateScanLine();
//   }

//   void _animateScanLine() {
//     ever(scanLinePosition, (_) {});

//     Future.doWhile(() async {
//       await Future.delayed(const Duration(milliseconds: 12));
//       if (!scanned.value) {
//         scanLinePosition.value += 0.01;
//         if (scanLinePosition.value >= 1) {
//           scanLinePosition.value = 0;
//         }
//       }
//       return true;
//     });
//   }

//   // When QR is detected
//   void onDetect(BarcodeCapture capture) {
//     if (scanned.value) return;

//     final code = capture.barcodes.first.rawValue ?? "";

//     if (code.isEmpty) {
//       errorToast("Invalid QR code");
//       return;
//     }

//     scanned.value = true;
//     scannedCode.value = code;

//     cameraController.stop();

//     // Small delay for animation / UX
//     Future.delayed(const Duration(milliseconds: 500), () {
//       Get.offNamed(
//         Routes.custDetails, // 👉 verification page
//         arguments: {
//           "coupon_code": code,
//         },
//       );
//     });
//   }

//   // Manual entry button

//   // Close page
//   void stopCamera() {
//     cameraController.stop();
//   }

//   void showCouponCodeDailogbox() {
//     Get.dialog(
//       CouponCodeDailogbox(
//         controller: codeCtrl,
//         onSubmit: () {
//           if (codeCtrl.text.trim().isEmpty) {
//             errorToast("Please enter a valid code");
//             return;
//           }

//           successToast("Code Entered: ${codeCtrl.text}");

//           Get.back(); // Close dialog

//           Get.toNamed(Routes.custDetails);
//         },
//       ),
//       barrierDismissible: false,
//     );
//   }
// }
