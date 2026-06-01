import 'package:get/get.dart';
import 'package:car_wash_partner/app/repositories/scanning_qr_code/scanning_repository.dart';
import 'package:car_wash_partner/app/routes/app_routes.dart';
import 'package:car_wash_partner/app/helpers/flutter_toast.dart';
import 'package:car_wash_partner/app/models/profile/all_services_model.dart';
import 'package:car_wash_partner/app/controllers/dashboard/dashboard_controller.dart';

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
      errorToast("invalid_payment_data".tr);
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
        errorToast("failed_to_redeem_coupon".tr);
        return;
      }

      successToast("payment_completed".tr);

      final history = resp.data["data"]["service_history"];

      // 🔥 Refresh the dashboard history immediately after redemption
      try {
        final dashboardController = Get.find<DashboardController>();
        await dashboardController.fetchPartnerHistory();
      } catch (_) {
        // Dashboard controller might not be loaded yet, that's ok
      }

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
      errorToast("something_went_wrong".tr);
    } finally {
      isLoading.value = false;
    }
  }
}
