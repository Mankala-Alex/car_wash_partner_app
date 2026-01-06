import 'package:get/get.dart';
import 'package:my_new_app/app/models/profile/all_services_model.dart';
import 'package:my_new_app/app/repositories/profile/profile_repostory.dart';
import '../../helpers/shared_preferences.dart';

class SelectServiceController extends GetxController {
  final ProfileRepository repository = ProfileRepository();

  var services = <AllServicesModel>[].obs;
  var isLoading = false.obs;

  // 🔥 selected service
  final selectedService = Rxn<AllServicesModel>();

  late String partnerId;
  late String couponCode;

  final int discountPercent = 50;

  @override
  void onInit() {
    super.onInit();
    couponCode = Get.arguments?['coupon_code'] ?? "";
    loadPartnerId();
  }

  Future<void> loadPartnerId() async {
    partnerId = await SharedPrefsHelper.getString("partnerId") ?? "";
    if (partnerId.isNotEmpty) {
      fetchServices();
    }
  }

  Future<void> fetchServices() async {
    try {
      isLoading.value = true;
      final resp = await repository.getPartnerServices(partnerId);
      final List list = resp.data['data'];
      services.value = list.map((e) => AllServicesModel.fromJson(e)).toList();
    } finally {
      isLoading.value = false;
    }
  }

  // ================= SELECTION =================
  void selectService(AllServicesModel service) {
    selectedService.value = service;
  }

  // ================= PRICE CALCULATIONS =================
  double get originalPrice {
    return selectedService.value?.price ?? 0.0;
  }

  double get totalAfterDiscount {
    if (selectedService.value == null) return 0.0;
    return originalPrice * (1 - discountPercent / 100);
  }
}
