import 'package:get/get.dart';

class ConfirmationScreenController extends GetxController {
  late String serviceName;
  late double originalAmount;
  late double finalAmount;
  late String couponCode;
  late String customerName;
  late String vehicleInfo;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    final service = args['service'];

    serviceName = service?.serviceName ?? "N/A";
    originalAmount = args['original_amount'] ?? 0.0;
    finalAmount = args['final_amount'] ?? 0.0;
    couponCode = args['coupon_code'] ?? "N/A";
    customerName = args['customer_name'] ?? "N/A";
    vehicleInfo = args['vehicle_info'] ?? "N/A";
  }
}
