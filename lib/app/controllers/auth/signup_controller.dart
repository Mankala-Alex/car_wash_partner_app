import 'package:car_wash_partner/app/repositories/auth/auth_repository.dart';
import 'package:car_wash_partner/app/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class SignupController extends GetxController {
  final AuthRepository repository = AuthRepository();

  // =========================================================
  // TEXT CONTROLLERS
  // =========================================================

  final companyNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final crNumberController = TextEditingController();

  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  // Address fields (kept for API compatibility)
  final streetNameController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final zipController = TextEditingController();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Current Location
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  // =========================================================
  // OBSERVABLES
  // =========================================================

  final isLoading = false.obs;

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  // Location selection state
  final isLocationSelected = false.obs;

  // =========================================================
  // REGISTER PARTNER
  // =========================================================

  Future<void> registerPartner() async {
    if (!_validateFields()) {
      return;
    }

    isLoading.value = true;

    try {
      final requestBody = {
        "company_name": companyNameController.text.trim(),
        "owner_name": ownerNameController.text.trim(),
        "cr_number": crNumberController.text.trim(),
        "phone_number": phoneNumberController.text.trim(),
        "email": emailController.text.trim(),
        "username": usernameController.text.trim(),
        "password": passwordController.text,
        "street_name": streetNameController.text.trim(),
        "district": districtController.text.trim(),
        "city": cityController.text.trim(),
        "country": countryController.text.trim(),
        "zip": zipController.text.trim(),

        // Current location
        "latitude": _parseDouble(latitudeController.text),
        "longitude": _parseDouble(longitudeController.text),
      };

      debugPrint("========== REGISTRATION REQUEST ==========");
      debugPrint("$requestBody");
      debugPrint("==========================================");

      final response = await repository.postapipartnerregister(requestBody);

      debugPrint("========== REGISTRATION RESPONSE ==========");
      debugPrint("${response.data}");
      debugPrint("===========================================");

      if (response.data != null && response.data["success"] == true) {
        final partner = response.data["partner"];

        final partnerId = partner?["id"];
        final partnerCode = partner?["partner_code"];
        final status = partner?["status"];

        debugPrint("Registration successful");
        debugPrint("Partner ID: $partnerId");
        debugPrint("Partner Code: $partnerCode");
        debugPrint("Status: $status");

        // Save FCM token for the pending partner (non-blocking for navigation)
        try {
          debugPrint(
              'Attempting to obtain FCM token for partnerId: $partnerId');
          final fcmToken = await FirebaseMessaging.instance.getToken();
          debugPrint('Obtained FCM token: $fcmToken');

          if (fcmToken != null && partnerId != null) {
            final resp = await repository.savePendingPartnerFcmToken(
              partnerId.toString(),
              fcmToken,
            );

            debugPrint(
                'savePendingPartnerFcmToken response status: ${resp.statusCode}');
            debugPrint(
                'savePendingPartnerFcmToken response data: ${resp.data}');
            debugPrint('Pending partner FCM token saved');
          } else {
            debugPrint(
                'No FCM token available or missing partnerId; skipping save.');
          }
        } catch (e, st) {
          debugPrint('FCM token save error: $e');
          debugPrint('$st');
        }

// Navigate to pending screen
        Get.toNamed(
          Routes.registrationPending,
          arguments: {
            "partner_id": partnerId,
            "partner_code": partnerCode,
            "status": status,
          },
        );
      } else {
        Get.snackbar(
          "Registration Failed",
          response.data?["message"] ??
              response.data?["error"] ??
              "Registration failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on DioException catch (e) {
      debugPrint("========== REGISTRATION ERROR ==========");
      debugPrint("Status Code: ${e.response?.statusCode}");
      debugPrint("Response Data: ${e.response?.data}");
      debugPrint("Request URL: ${e.requestOptions.uri}");
      debugPrint("Request Data: ${e.requestOptions.data}");
      debugPrint("=========================================");

      Get.snackbar(
        "Registration Failed",
        e.response?.data?["message"]?.toString() ??
            e.response?.data?["error"]?.toString() ??
            "Registration failed",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint("Unexpected registration error: $e");

      Get.snackbar(
        "Registration Failed",
        "Unable to complete registration.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  bool _validateFields() {
    if (companyNameController.text.trim().isEmpty) {
      _showError("Please enter company name");
      return false;
    }

    if (ownerNameController.text.trim().isEmpty) {
      _showError("Please enter owner name");
      return false;
    }

    if (crNumberController.text.trim().isEmpty) {
      _showError("Please enter CR number");
      return false;
    }

    if (phoneNumberController.text.trim().isEmpty) {
      _showError("Please enter phone number");
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      _showError("Please enter email");
      return false;
    }

    if (usernameController.text.trim().isEmpty) {
      _showError("Please enter username");
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showError("Please enter password");
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      _showError("Please confirm password");
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showError("Passwords do not match");
      return false;
    }

    // Location must be selected
    if (latitudeController.text.trim().isEmpty ||
        longitudeController.text.trim().isEmpty) {
      _showError("Please select your current location");
      return false;
    }

    if (double.tryParse(latitudeController.text.trim()) == null) {
      _showError("Invalid latitude");
      return false;
    }

    if (double.tryParse(longitudeController.text.trim()) == null) {
      _showError("Invalid longitude");
      return false;
    }

    return true;
  }

  // =========================================================
  // GET CURRENT LOCATION
  // =========================================================

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      // Check if location service is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        Get.snackbar(
          "Location Required",
          "Please enable location services.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      // Request permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Still denied
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Permanently denied
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Permission Required",
          "Please enable location permission from Settings.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Get current position
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Save coordinates
      latitudeController.text = position.latitude.toString();

      longitudeController.text = position.longitude.toString();

      // Mark location as selected for GetX UI updates
      isLocationSelected.value = true;

      debugPrint(
        "Current Latitude: ${position.latitude}",
      );

      debugPrint(
        "Current Longitude: ${position.longitude}",
      );

      Get.snackbar(
        "Location Selected",
        "Current location fetched successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint("Location error: $e");

      Get.snackbar(
        "Location Error",
        "Unable to get your current location.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // PARSE DOUBLE
  // =========================================================

  double? _parseDouble(String value) {
    if (value.trim().isEmpty) {
      return null;
    }

    return double.tryParse(value.trim());
  }

  // =========================================================
  // ERROR
  // =========================================================

  void _showError(String message) {
    Get.snackbar(
      "Required",
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void onClose() {
    companyNameController.dispose();
    ownerNameController.dispose();
    crNumberController.dispose();

    phoneNumberController.dispose();
    emailController.dispose();

    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    latitudeController.dispose();
    longitudeController.dispose();

    streetNameController.dispose();
    districtController.dispose();
    cityController.dispose();
    countryController.dispose();
    zipController.dispose();

    super.onClose();
  }
}
