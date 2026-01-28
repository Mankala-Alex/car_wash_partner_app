import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/profile/all_services_controller.dart';

class AllServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllServicesController>(() => AllServicesController());
  }
}
