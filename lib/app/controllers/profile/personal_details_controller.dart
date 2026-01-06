import 'package:get/get.dart';
import 'package:my_new_app/app/helpers/shared_preferences.dart';

class PersonalDetailsController extends GetxController {
  var companyName = "".obs;
  var ownerName = "".obs;
  var partnerCode = "".obs;
  var bannerImage = "".obs;
  var status = "".obs;

  var city = "".obs;
  var district = "".obs;
  var country = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  Future<void> loadDetails() async {
    companyName.value =
        await SharedPrefsHelper.getString("partnerCompanyName") ?? "";

    ownerName.value =
        await SharedPrefsHelper.getString("partnerOwnerName") ?? "";

    partnerCode.value = await SharedPrefsHelper.getString("partnerCode") ?? "";

    bannerImage.value = await SharedPrefsHelper.getString("partnerImage") ?? "";

    city.value = await SharedPrefsHelper.getString("partnerCity") ?? "";

    district.value = await SharedPrefsHelper.getString("partnerDistrict") ?? "";

    country.value = await SharedPrefsHelper.getString("partnerCountry") ?? "";

    status.value = "Approved Partner";
  }
}
