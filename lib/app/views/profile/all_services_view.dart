import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/profile/all_services_controller.dart';
import 'package:my_new_app/app/theme/app_theme.dart';
import 'package:my_new_app/app/views/profile/add_service_view.dart';

class AllServicesView extends GetView<AllServicesController> {
  const AllServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: const Text("Partner Services"),
        centerTitle: true,
        backgroundColor: AppColors.bgLight,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.services.isEmpty) {
          return const Center(
            child: Text("No services added yet"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.services.length,
          itemBuilder: (context, index) {
            final service = controller.services[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          service.serviceName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      // 🔥 ACTION BUTTONS
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              final updated = await Get.dialog(
                                AddServiceView(
                                  isEdit: true,
                                  service: service,
                                ),
                              );

                              if (updated == true) {
                                controller.fetchServices();
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text("Delete Service"),
                                  content: const Text(
                                      "Are you sure you want to delete this service?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                        controller.deleteService(service.id);
                                      },
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (service.description != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      service.description!,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Text(
                    "₹ ${service.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.successLight,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final added = await Get.dialog(const AddServiceView());
          if (added == true) {
            controller.fetchServices();
          }
        },
        backgroundColor: AppColors.secondaryLight,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const SizedBox(
          width: 90, // 👈 controls wrap width
          child: Text(
            "Add Service",
            textAlign: TextAlign.center,
            maxLines: 2, // 👈 allows wrap
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
