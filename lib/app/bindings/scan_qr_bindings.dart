import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/scan_qr_controller.dart';

class ScanQrBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrController>(() => ScanQrController());
  }
}
