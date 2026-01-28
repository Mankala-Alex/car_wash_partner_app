import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/scan_qr_controller.dart';

class ScanQrBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanQrController>(() => ScanQrController());
  }
}
