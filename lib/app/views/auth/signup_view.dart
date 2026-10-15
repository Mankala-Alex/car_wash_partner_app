import 'package:car_wash_partner/app/controllers/auth/signup_controller.dart';
import 'package:car_wash_partner/app/custome_widgets/loader.dart';
import 'package:car_wash_partner/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "partner_registration".tr,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Image.asset(
                          "assets/icons/profile.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "create_partner_account".tr,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "enter_your_company_details_to_register".tr,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // =========================
              // COMPANY DETAILS
              // =========================

              _sectionTitle(
                context,
                "company_details".tr,
              ),

              const SizedBox(height: 15),

              _field(
                label: "company_name".tr,
                hint: "enter_company_name".tr,
                icon: Icons.business_outlined,
                controller: controller.companyNameController,
              ),

              const SizedBox(height: 18),

              _field(
                label: "owner_name".tr,
                hint: "enter_owner_name".tr,
                icon: Icons.person_outline,
                controller: controller.ownerNameController,
              ),

              const SizedBox(height: 18),

              _field(
                label: "cr_number".tr,
                hint: "enter_cr_number".tr,
                icon: Icons.badge_outlined,
                controller: controller.crNumberController,
              ),

              const SizedBox(height: 30),

              // =========================
              // CONTACT DETAILS
              // =========================

              _sectionTitle(
                context,
                "contact_details".tr,
              ),

              const SizedBox(height: 15),

              _field(
                label: "phone_number".tr,
                hint: "enter_phone_number".tr,
                icon: Icons.phone_outlined,
                controller: controller.phoneNumberController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 18),

              _field(
                label: "email".tr,
                hint: "enter_email_address".tr,
                icon: Icons.email_outlined,
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 30),

              // =========================
              // LOGIN DETAILS
              // =========================

              _sectionTitle(
                context,
                "login_details".tr,
              ),

              const SizedBox(height: 15),

              _field(
                label: "username".tr,
                hint: "enter_username".tr,
                icon: Icons.person_outline,
                controller: controller.usernameController,
              ),

              const SizedBox(height: 18),

              // Password
              Text(
                "password".tr,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black45,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.isPasswordHidden.toggle();
                        },
                      ),
                      hintText: "enter_password".tr,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Confirm Password
              Text(
                "confirm_password".tr,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: TextField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.isConfirmPasswordHidden.value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black45,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          controller.isConfirmPasswordHidden.toggle();
                        },
                      ),
                      hintText: "confirm_password_hint".tr,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // ADDRESS DETAILS
              // =========================

              _sectionTitle(
                context,
                "address_details".tr,
              ),

              const SizedBox(height: 15),

              _field(
                label: "street_name".tr,
                hint: "enter_street_name".tr,
                icon: Icons.location_on_outlined,
                controller: controller.streetNameController,
              ),

              const SizedBox(height: 18),

              _field(
                label: "district".tr,
                hint: "enter_district".tr,
                icon: Icons.location_city_outlined,
                controller: controller.districtController,
              ),

              const SizedBox(height: 18),

              _field(
                label: "city".tr,
                hint: "enter_city".tr,
                icon: Icons.location_city,
                controller: controller.cityController,
              ),

              const SizedBox(height: 18),

              _field(
                label: "country".tr,
                hint: "enter_country".tr,
                icon: Icons.public,
                controller: controller.countryController,
              ),

              const SizedBox(height: 18),

              _field(
                label: "zip_code".tr,
                hint: "enter_zip_code".tr,
                icon: Icons.markunread_mailbox_outlined,
                controller: controller.zipController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 30),

              // =========================
              // LOCATION
              // =========================

              _sectionTitle(
                context,
                "location".tr,
              ),

              const SizedBox(height: 15),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            await controller.getCurrentLocation();
                          },
                    icon: const Icon(Icons.my_location),
                    label: Text(
                      "use_current_location".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Obx(
                () {
                  if (!controller.isLocationSelected.value) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "current_location_selected".tr,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${"latitude".tr}: ${controller.latitudeController.text}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${"longitude".tr}: ${controller.longitudeController.text}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 35),

              // =========================
              // REGISTER BUTTON
              // =========================

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            await controller.registerPartner();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryLight,
                      disabledBackgroundColor:
                          AppColors.secondaryLight.withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? loader()
                        : Text(
                            "register".tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "already_have_an_account_login".tr,
                    style: const TextStyle(
                      color: AppColors.secondaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(
    BuildContext context,
    String title,
  ) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
    );
  }

  Widget _field({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                icon,
                color: Colors.black45,
              ),
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
