import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/profile/all_services_controller.dart';

class AllServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllServicesController>(() => AllServicesController());
  }
}
