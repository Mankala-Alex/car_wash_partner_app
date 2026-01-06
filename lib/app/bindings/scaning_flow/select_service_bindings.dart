import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/select_service_controller.dart';

class SelectServiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectServiceController>(() => SelectServiceController());
  }
}
