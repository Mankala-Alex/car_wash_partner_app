import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/scanning_flow/payment_screen_controller.dart';

class PaymentScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentScreenController>(() => PaymentScreenController());
  }
}
