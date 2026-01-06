import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scanning_flow/cust_details_controller.dart';

class CustDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustDetailsController>(() => CustDetailsController());
  }
}
