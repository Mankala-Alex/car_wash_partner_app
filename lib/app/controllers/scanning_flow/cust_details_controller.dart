import 'package:get/get.dart';

class CustDetailsController extends GetxController {
  Map<String, dynamic>? data;

  // 🔴 ADD THIS
  late String couponCode;

  late String customerName;
  late String customerPhone;
  late String customerEmail;

  late String vehicleName;
  late String licensePlate;

  late int discountPercent;
  late String couponStatus;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args == null || args is! Map<String, dynamic>) {
      Get.back();
      return;
    }

    data = args;

    // 🔴 ADD THIS (coupon code comes from API response)
    couponCode = data!['coupon']['coupon_code'];

    // COUPON
    discountPercent = data!['coupon']['discount_percent'];
    couponStatus = data!['coupon']['status'];

    // CUSTOMER
    customerName = data!['customer']['name'] ?? "N/A";
    customerPhone = data!['customer']['phone'] ?? "N/A";
    customerEmail = data!['customer']['email'] ?? "N/A";

    // VEHICLE
    if (data!['vehicle'] != null) {
      vehicleName = "${data!['vehicle']['make']} ${data!['vehicle']['model']}";
      licensePlate = data!['vehicle']['number'];
    } else {
      vehicleName = "Not available";
      licensePlate = "Not available";
    }
  }
}
