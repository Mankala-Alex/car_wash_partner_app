import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/confirmation_screen_controller.dart';

class ConfirmationScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmationScreenController>(
        () => ConfirmationScreenController());
  }
}
