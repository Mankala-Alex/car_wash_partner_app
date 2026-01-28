import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/profile/personal_details_controller.dart';

class PersonalDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDetailsController>(() => PersonalDetailsController());
  }
}
