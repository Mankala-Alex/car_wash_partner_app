import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/profile/add_service_controller.dart';

class AddServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddServiceController>(
        () => AddServiceController(isEdit: false));
  }
}
