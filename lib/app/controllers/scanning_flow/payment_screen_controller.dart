import 'package:get/get.dart';
import 'package:my_new_app/app/repositories/scanning_qr_code/scanning_repository.dart';
import 'package:my_new_app/app/routes/app_routes.dart';
import 'package:my_new_app/app/helpers/flutter_toast.dart';
import 'package:my_new_app/app/models/profile/all_services_model.dart';

class PaymentScreenController extends GetxController {
  final ScanningRepository repository = ScanningRepository();

  final isLoading = false.obs;

  late String couponCode;
  late String partnerId;
  late AllServicesModel service;
  late double originalAmount;
  late double finalAmount;

  late String vehicleName;
  late String vehicleNumber;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    couponCode = args['coupon_code'] ?? "";
    partnerId = args['partner_id'] ?? "";
    service = args['service'];
    originalAmount = args['original_amount'] ?? 0.0;
    finalAmount = args['final_amount'] ?? 0.0;

    // ✅ NEW
    vehicleName = args['vehicle_name'] ?? "N/A";
    vehicleNumber = args['vehicle_number'] ?? "N/A";

    if (couponCode.isEmpty || partnerId.isEmpty) {
      errorToast("Invalid payment data");
    }
  }

  // 🔥 REDEEM HAPPENS HERE
  Future<void> redeemAndContinue() async {
    try {
      isLoading.value = true;

      final resp = await repository.postRedeemCoupon({
        "coupon_code": couponCode,
        "partner_id": partnerId,
        "service_name": service.serviceName,
        "original_amount": originalAmount.toStringAsFixed(2),
        "final_amount": finalAmount.toStringAsFixed(2),
      });

      if (resp.data["success"] != true) {
        errorToast("Failed to redeem coupon");
        return;
      }

      successToast("Payment completed");

      final history = resp.data["data"]["service_history"];

      Get.offNamed(
        Routes.confirmationScreen,
        arguments: {
          "service": service,
          "original_amount": originalAmount,
          "final_amount": finalAmount,
          "coupon_code": couponCode,
          "customer_name": history["customer_name"] ?? "N/A",
          "vehicle_info":
              history["vehicle_info"] ?? history["vehicle_number"] ?? "N/A",
        },
      );
    } catch (e) {
      errorToast("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
