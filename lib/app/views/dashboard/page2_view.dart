import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/dashboard/dashboard_controller.dart';
import 'package:car_wash_partner/app/models/dashboard/partner_service_history_model.dart';
import 'package:car_wash_partner/app/theme/app_theme.dart';

class Page2View extends GetView<DashboardController> {
  const Page2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- HEADER ----------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Service History",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            const SizedBox(height: 10),

            // ---------------- SEARCH BAR ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.borderGray),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Colors.black, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText:
                                    "Search service name or customer name ",
                                border: InputBorder.none,
                              ),
                              onChanged: controller.onSearchChanged,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- RECENT ACTIVITY TITLE ----------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Recent Activity",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                // 🔄 Loading state
                if (controller.isHistoryLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // ❌ No data after search
                if (controller.filteredHistoryList.isEmpty) {
                  return const Center(
                    child: Text(
                      "No history found",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  );
                }

                // ✅ Show filtered list
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.filteredHistoryList.length,
                  itemBuilder: (context, index) {
                    return _historyCard(controller.filteredHistoryList[index]);
                  },
                );
              }),
            ),

            const SizedBox(height: 10),

            Obx(() {
              if (controller.historyList.isEmpty) return const SizedBox();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.secondaryLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Admin Payable",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "₹${controller.totalAdminPayable.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String _day(DateTime d) => d.day.toString();
  String _month(DateTime d) => [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ][d.month - 1];

  Widget _historyCard(PartnerServiceHistoryModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // DATE
            Container(
              width: 80,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("DATE",
                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                  Text(_day(item.createdAt),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(_month(item.createdAt),
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SERVICE + PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.serviceName,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "₹${item.finalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text("Customer: ${item.customerName}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.brown)),

                    const SizedBox(height: 6),

                    Text("Vehicle: ${item.vehicleNumber}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black)),

                    const SizedBox(height: 6),

                    Text(
                      "Admin Payable: ₹${item.adminPayable.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
