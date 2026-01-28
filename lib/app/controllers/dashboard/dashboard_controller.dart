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
  // Search text
  var searchQuery = "".obs;

  // Sample service history → you can replace from API

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

  Future<void> fetchPartnerHistory() async {
    try {
      isHistoryLoading.value = true;

      final partnerId = await SharedPrefsHelper.getString("partnerId") ?? "";
      if (partnerId.isEmpty) return;

      final resp = await repository.getPartnerHistory(partnerId);
      final List list = resp.data['data'];

      final data =
          list.map((e) => PartnerServiceHistoryModel.fromJson(e)).toList();

      historyList.value = data;
      filteredHistoryList.value = data; // 🔥 initialize filtered list
    } catch (e) {
      print("❌ History fetch error: $e");
    } finally {
      isHistoryLoading.value = false;
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredHistoryList.value = historyList;
      return;
    }

    final q = query.toLowerCase();

    filteredHistoryList.value = historyList.where((item) {
      return item.serviceName.toLowerCase().contains(q) ||
          item.customerName.toLowerCase().contains(q) ||
          item.vehicleNumber.toLowerCase().contains(q);
    }).toList();
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
