import 'package:car_wash_partner/app/controllers/auth/registartion_pending_controller.dart';
import 'package:get/get.dart';

class RegistrationPendingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistartionPendingController());
  }
}
