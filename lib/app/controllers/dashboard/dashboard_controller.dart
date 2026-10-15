import 'package:get/get.dart';
import 'package:car_wash_partner/app/helpers/shared_preferences.dart';
import 'package:car_wash_partner/app/models/dashboard/partner_service_history_model.dart';
import 'package:car_wash_partner/app/repositories/auth/auth_repository.dart';
import 'package:car_wash_partner/app/repositories/scanning_qr_code/scanning_repository.dart';
import 'package:car_wash_partner/app/routes/app_routes.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final ScanningRepository repository = ScanningRepository();
  final AuthRepository _authRepo = AuthRepository();
  var historyList = <PartnerServiceHistoryModel>[].obs;
  var filteredHistoryList = <PartnerServiceHistoryModel>[].obs;
  var isHistoryLoading = false.obs;
  var isFilterLoading = false.obs;

  // 🔥 Month / Year filter state (month 0 = All months)
  var selectedMonth = 0.obs;
  var selectedYear = DateTime.now().year.obs;

  // 🔥 Animation variable for QR tap
  var qrScale = 1.0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  // 🔥 Animation + Navigation
  void onQrTap() async {
    qrScale.value = 0.92; // shrink
    await Future.delayed(const Duration(milliseconds: 120));
    qrScale.value = 1.0; // back to normal
    await Future.delayed(const Duration(milliseconds: 80));

    // Now open camera page
    Get.toNamed(Routes.scanQr);
  }

  //history screen

  //profile screen

  // 🔹 Partner info
  var companyName = "".obs;
  var partnerCode = "".obs;
  //var status = "".obs;
  var ownerName = "".obs;
  var bannerImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadPartnerProfile();
    fetchPartnerHistory();
  }

  Future<void> loadPartnerProfile() async {
    companyName.value =
        await SharedPrefsHelper.getString("partnerCompanyName") ?? "";

    partnerCode.value = await SharedPrefsHelper.getString("partnerCode") ?? "";

    bannerImage.value = await SharedPrefsHelper.getString("partnerImage") ?? "";
    ownerName.value =
        await SharedPrefsHelper.getString("partnerOwnerName") ?? "";
    //status.value = "Community Partner"; // or use backend status
  }

  Future<void> fetchPartnerHistory({int? month, int? year}) async {
    final isFilter = month != null && year != null;
    try {
      if (isFilter) {
        isFilterLoading.value = true;
      } else {
        isHistoryLoading.value = true;
      }

      final partnerId = await SharedPrefsHelper.getString("partnerId") ?? "";
      if (partnerId.isEmpty) return;

      final resp = await repository.getPartnerHistory(
        partnerId,
        month: month,
        year: year,
      );

      final List list = resp.data['data'];

      final data =
          list.map((e) => PartnerServiceHistoryModel.fromJson(e)).toList();

      if (isFilter) {
        filteredHistoryList.value = data;
      } else {
        historyList.value = data;
        filteredHistoryList.value = data; // 🔥 initialize filtered list
      }
    } catch (e) {
      print("❌ History fetch error: $e");
    } finally {
      if (isFilter) {
        isFilterLoading.value = false;
      } else {
        isHistoryLoading.value = false;
      }
    }
  }

  // 🔥 Called when month / year filter changes
  Future<void> applyMonthYearFilter(int month, int year) async {
    selectedMonth.value = month;
    selectedYear.value = year;

    // month 0 = All → fetch everything without filters
    await fetchPartnerHistory(
      month: month == 0 ? null : month,
      year: month == 0 ? null : year,
    );
  }

// 🔥 Total Admin Payable (reactive) — based on the currently shown list
  double get totalAdminPayable {
    return filteredHistoryList.fold(
      0.0,
      (sum, item) => sum + item.adminPayable,
    );
  }

  // 🔥 Admin Paid amount — sum of admin payable where payment is PAID
  double get totalAdminPaid {
    return filteredHistoryList
        .where((item) => item.paymentStatus.toUpperCase() == "PAID")
        .fold(0.0, (sum, item) => sum + item.adminPayable);
  }

  Future<void> logout() async {
    try {
      // 1️⃣ Call logout API
      await _authRepo.partnerLogout();
    } catch (e) {
      // API failure should NOT block logout
      print("Logout API error: $e");
    } finally {
      // 2️⃣ Clear local data ALWAYS
      await SharedPrefsHelper.clearAll();

      // 3️⃣ Reset GetX state
      Get.deleteAll(force: true);

      // 4️⃣ Navigate to login
      Get.offAllNamed(Routes.login);
    }
  }
}
