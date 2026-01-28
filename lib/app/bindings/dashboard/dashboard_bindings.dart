import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/dashboard/dashboard_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
