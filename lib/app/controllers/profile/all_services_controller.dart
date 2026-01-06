import 'package:get/get.dart';
import 'package:my_new_app/app/models/profile/all_services_model.dart';
import 'package:my_new_app/app/repositories/profile/profile_repostory.dart';
import '../../helpers/shared_preferences.dart';

class AllServicesController extends GetxController {
  final ProfileRepository repository = ProfileRepository();

  var isLoading = false.obs;
  var services = <AllServicesModel>[].obs;

  late String partnerId;

  @override
  void onInit() {
    super.onInit();
    loadPartnerId();
  }

  Future<void> loadPartnerId() async {
    partnerId = await SharedPrefsHelper.getString("partnerId") ?? "";

    print("🔥 Loaded partnerId: $partnerId");

    if (partnerId.isEmpty) {
      print("❌ partnerId is empty. Services will not load.");
      return;
    }

    fetchServices();
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await repository.deleteService(partnerId, serviceId);
      services.removeWhere((e) => e.id == serviceId); // optimistic update
    } catch (_) {
      Get.snackbar("Error", "Failed to delete service");
    }
  }

  Future<void> fetchServices() async {
    if (partnerId.isEmpty) return;

    try {
      isLoading.value = true;

      final response = await repository.getPartnerServices(partnerId);
      final List list = response.data['data'];

      services.value = list.map((e) => AllServicesModel.fromJson(e)).toList();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editService(
    String serviceId,
    Map<String, dynamic> body,
  ) async {
    try {
      final resp = await repository.editService(
        partnerId,
        serviceId,
        body,
      );

      final updated = AllServicesModel.fromJson(resp.data['data']);

      final index = services.indexWhere((e) => e.id == serviceId);
      if (index != -1) {
        services[index] = updated; // 🔥 update list item
      }
    } catch (_) {
      Get.snackbar("Error", "Failed to update service");
    }
  }
}
