import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/profile/personal_details_controller.dart';

class PersonalDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDetailsController>(() => PersonalDetailsController());
  }
}
