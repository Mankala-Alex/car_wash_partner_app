import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/scanning_flow/confirmation_screen_controller.dart';

class ConfirmationScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmationScreenController>(
        () => ConfirmationScreenController());
  }
}
