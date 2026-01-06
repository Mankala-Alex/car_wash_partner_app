import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/helpers/shared_preferences.dart';
import 'package:my_new_app/app/models/profile/all_services_model.dart';
import 'package:my_new_app/app/repositories/profile/profile_repostory.dart';

class AddServiceController extends GetxController {
  final ProfileRepository repository = ProfileRepository();

  final bool isEdit;
  final AllServicesModel? service;

  AddServiceController({
    required this.isEdit,
    this.service,
  });

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  var isLoading = false.obs;
  late String partnerId;

  @override
  void onInit() {
    super.onInit();
    loadPartnerId();

    // 🔥 PREFILL FOR EDIT
    if (isEdit && service != null) {
      nameCtrl.text = service!.serviceName;
      descCtrl.text = service!.description ?? "";
      priceCtrl.text = service!.price.toString();
    }
  }

  Future<void> loadPartnerId() async {
    partnerId = await SharedPrefsHelper.getString("partnerId") ?? "";
  }

  Future<void> submitService() async {
    if (partnerId.isEmpty) {
      Get.snackbar("Error", "Partner not found. Please re-login.");
      return;
    }

    if (nameCtrl.text.trim().isEmpty || priceCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "Service name & price are required");
      return;
    }

    final body = {
      "service_name": nameCtrl.text.trim(),
      "description": descCtrl.text.trim(),
      "price": double.parse(priceCtrl.text.trim()),
    };

    try {
      isLoading.value = true;

      if (isEdit) {
        await repository.editService(
          partnerId,
          service!.id,
          body,
        );
      } else {
        await repository.addPartnerService(partnerId, body);
      }

      Get.back(result: true);
    } catch (_) {
      Get.snackbar("Error", isEdit ? "Update failed" : "Add failed");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
    super.onClose();
  }
}
