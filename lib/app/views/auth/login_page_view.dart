import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_new_app/app/controllers/auth/login_controller.dart';
import 'package:my_new_app/app/custome_widgets/loader.dart';
import 'package:my_new_app/app/theme/app_theme.dart';

class LoginPageView extends GetView<LoginController> {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Logo box
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
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

            const SizedBox(height: 30),

            Text(
              "Partner Login",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Manage QR discounts efficiently.",
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 40),

            // Username Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Username Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                controller: controller.usernameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person, color: Colors.black45),
                  hintText: "Enter your username",
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Password Label
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Password Field with Toggle
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black12),
                ),
                child: TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.black45),
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
                    hintText: "Enter your password",
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.loginPartner(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Obx(() => controller.isLoading.value
                    ? loader()
                    : const Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
