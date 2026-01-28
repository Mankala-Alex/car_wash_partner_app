import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_partner/app/models/dashboard/partner_service_history_model.dart';
import '../../controllers/dashboard/dashboard_controller.dart';
import '../../theme/app_theme.dart';

class Page1View extends GetView<DashboardController> {
  const Page1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== SCANNER HEADER ====================
            GestureDetector(
              onTap: controller.onQrTap,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.50,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Obx(() => AnimatedScale(
                                    scale: controller.qrScale.value,
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeOut,
                                    child: Container(
                                      width: 260,
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(
                                            Icons.qr_code_2_rounded,
                                            size: 200,
                                            color: Colors.white,
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            child: Text(
                                              "Tap to scan",
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 30),
                              const Text(
                                "Scan Customer QR Code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ==================== TODAY'S JOBS ====================
            // ==================== PREVIOUS SERVICE ====================
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Previous Service",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                if (controller.isHistoryLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.historyList.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "No previous services",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  );
                }

                final item = controller.historyList.first; // ✅ LATEST ITEM

                return _previousServiceCard(item);
              }),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _previousServiceCard(PartnerServiceHistoryModel item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SERVICE + AMOUNT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.serviceName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "₹${item.finalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Customer: ${item.customerName}",
            style: const TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 6),

          Text(
            "Vehicle: ${item.vehicleNumber}",
            style: const TextStyle(color: Colors.black),
          ),

          const SizedBox(height: 6),

          Text(
            "Admin Payable: ₹${item.adminPayable.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== JOB CARD ====================
  Widget _jobCard(String name, String car, String time, String status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(car, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 18, color: Colors.black45),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(color: Colors.black)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: status == "IN PROGRESS"
                      ? Colors.blue.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color:
                        status == "IN PROGRESS" ? Colors.blue : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ==================== RECENT ACTIVITY CARD ====================
  Widget _recentCard(IconData icon, String name, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.secondaryLight.withOpacity(0.2),
            child: Icon(icon, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                    )),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
        ],
      ),
    );
  }
}
