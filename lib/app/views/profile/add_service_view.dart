import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/profile/add_service_controller.dart';
import 'package:car_wash_partner/app/models/profile/all_services_model.dart';
import 'package:car_wash_partner/app/theme/app_theme.dart';

class AddServiceView extends StatelessWidget {
  final bool isEdit;
  final AllServicesModel? service;

  const AddServiceView({
    super.key,
    this.isEdit = false,
    this.service,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AddServiceController(
        isEdit: isEdit,
        service: service,
      ),
    );

    return Dialog(
      backgroundColor: AppColors.bgLight,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? "Edit Service" : "Add New Service",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _field("Service Name", controller.nameCtrl),
                _field("Description", controller.descCtrl, maxLines: 3),
                _field(
                  "Price",
                  controller.priceCtrl,
                  keyboard: TextInputType.number,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitService,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            isEdit ? "Update Service" : "Add Service",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboard,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
