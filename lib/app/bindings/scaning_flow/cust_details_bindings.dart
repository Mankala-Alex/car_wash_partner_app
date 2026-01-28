import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/scanning_flow/cust_details_controller.dart';

class CustDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustDetailsController>(() => CustDetailsController());
  }
}
