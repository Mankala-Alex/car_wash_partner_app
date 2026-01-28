import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/profile/add_service_controller.dart';

class AddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddServiceController>(
        () => AddServiceController(isEdit: false));
  }
}
