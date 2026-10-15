import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_partner/app/controllers/dashboard/dashboard_controller.dart';
import 'package:car_wash_partner/app/custome_widgets/custome_dropdown.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "service_history".tr,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            const SizedBox(height: 10),

            // ---------------- MONTH / YEAR FILTER ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      label: "month".tr,
                      items: _monthFilterItems(),
                      selectedKey: controller.selectedMonth.value.toString(),
                      onChanged: (key) {
                        if (key == null || key.isEmpty) return;
                        controller.applyMonthYearFilter(
                          int.parse(key),
                          controller.selectedYear.value,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomDropdown(
                      label: "year".tr,
                      items: _yearFilterItems(),
                      selectedKey: controller.selectedYear.value.toString(),
                      onChanged: (key) {
                        if (key == null || key.isEmpty) return;
                        controller.applyMonthYearFilter(
                          controller.selectedMonth.value,
                          int.parse(key),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ---------------- RECENT ACTIVITY TITLE ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "recent_activity".tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                // 🔄 Loading state
                if (controller.isHistoryLoading.value ||
                    controller.isFilterLoading.value) {
                  return _skeletonList();
                }

                // ❌ No data after search
                if (controller.filteredHistoryList.isEmpty) {
                  return Center(
                    child: Text(
                      "no_history_found".tr,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
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
              if (controller.filteredHistoryList.isEmpty) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.secondaryLight),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "total_admin_payable".tr,
                            style: const TextStyle(
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
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "admin_paid".tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "₹${controller.totalAdminPaid.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
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
        "jan".tr,
        "feb".tr,
        "mar".tr,
        "april".tr,
        "may".tr,
        "jun".tr,
        "jul".tr,
        "aug".tr,
        "sep".tr,
        "oct".tr,
        "nov".tr,
        "dec".tr
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
                  Text("date".tr,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54)),
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

                    Text("${"customer".tr}: ${item.customerName}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.brown)),

                    const SizedBox(height: 6),

                    Text("${"vehicle".tr}: ${item.vehicleNumber}",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black)),

                    const SizedBox(height: 6),

                    Text(
                      "${"admin_payable".tr}: ₹${item.adminPayable.toStringAsFixed(2)}",
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

  // ---------------- FILTER HELPERS ----------------
  String _monthLabel(int m) => [
        "jan".tr,
        "feb".tr,
        "mar".tr,
        "april".tr,
        "may".tr,
        "jun".tr,
        "jul".tr,
        "aug".tr,
        "sep".tr,
        "oct".tr,
        "nov".tr,
        "dec".tr
      ][m - 1];

  List<Map<String, String>> _monthFilterItems() {
    return [
      {"0": "all_months".tr},
      for (int m = 1; m <= 12; m++) {"$m": _monthLabel(m)},
    ];
  }

  List<Map<String, String>> _yearFilterItems() {
    final currentYear = DateTime.now().year;
    return [
      for (int y = currentYear; y >= currentYear - 5; y--) {"$y": "$y"},
    ];
  }

  Widget _skeletonList() {
    return _SkeletonPulse(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 4,
        itemBuilder: (context, index) => _skeletonCard(),
      ),
    );
  }

  Widget _skeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGray),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _skeletonBox(width: 80, height: 80, radius: 12),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _skeletonBox(width: 140, height: 16),
                const SizedBox(height: 10),
                _skeletonBox(width: double.infinity, height: 12),
                const SizedBox(height: 8),
                _skeletonBox(width: 180, height: 12),
                const SizedBox(height: 8),
                _skeletonBox(width: 120, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _skeletonBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _SkeletonPulse extends StatefulWidget {
  final Widget child;
  const _SkeletonPulse({required this.child});

  @override
  State<_SkeletonPulse> createState() => _SkeletonPulseState();
}

class _SkeletonPulseState extends State<_SkeletonPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.35, end: 0.85).animate(_controller),
      child: widget.child,
    );
  }
}
