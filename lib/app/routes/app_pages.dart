import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/route_manager.dart';
import 'package:car_wash_partner/app/bindings/profile/add_service_binding.dart';
import 'package:car_wash_partner/app/bindings/profile/all_services_binding.dart';
import 'package:car_wash_partner/app/bindings/profile/change_password_binding.dart';
import 'package:car_wash_partner/app/bindings/profile/lang_change_binding.dart';
import 'package:car_wash_partner/app/bindings/profile/personal_details_binding.dart';
import 'package:car_wash_partner/app/bindings/scaning_flow/confirmation_screen_controller.dart';
import 'package:car_wash_partner/app/bindings/scaning_flow/cust_details_bindings.dart';
import 'package:car_wash_partner/app/bindings/scaning_flow/payment_screen_bindings.dart';
import 'package:car_wash_partner/app/bindings/scaning_flow/select_service_bindings.dart';
import 'package:car_wash_partner/app/bindings/dashboard/dashboard_bindings.dart';
import 'package:car_wash_partner/app/bindings/scan_qr_bindings.dart';
import 'package:car_wash_partner/app/views/profile/add_service_view.dart';
import 'package:car_wash_partner/app/views/profile/all_services_view.dart';
import 'package:car_wash_partner/app/views/profile/change_password_view.dart';
import 'package:car_wash_partner/app/views/profile/lang_change_view.dart';
import 'package:car_wash_partner/app/views/profile/personal_details_view.dart';
import 'package:car_wash_partner/app/views/scanning_flow/confirmation_screen_view.dart';
import 'package:car_wash_partner/app/views/scanning_flow/cust_details_view.dart';
import 'package:car_wash_partner/app/views/scanning_flow/payment_screen_view.dart';
import 'package:car_wash_partner/app/views/scanning_flow/select_service_view.dart';
import 'package:car_wash_partner/app/views/dashboard/dashboard_view.dart';
import 'package:car_wash_partner/app/views/scan_qr_view.dart';

import '../bindings/auth/lang_selection_binding.dart';
import '../bindings/auth/login_binding.dart';
import '../bindings/auth/otp_binding.dart';
import '../bindings/splash_screen_bindings.dart';
import '../views/auth/lang_selection_view.dart';
import '../views/auth/login_page_view.dart';
import '../views/auth/otp_screen_view.dart';
import '../views/splash_screen_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initialPage = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreenView(),
      binding: SplashScreenBindings(),
    ),
    GetPage(
      name: Routes.langeSelection,
      page: () => const LangSelectionView(),
      binding: LangSelectionBindings(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPageView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.otpPage,
      page: () => const OtpScreenView(),
      binding: OtpBinding(),
    ),

    //dashboard

    GetPage(
      name: Routes.dashboard,
      page: () => DashboardView(),
      binding: DashboardBindings(),
    ),
    GetPage(
      name: Routes.scanQr,
      page: () => const ScanQrView(),
      binding: ScanQrBindings(),
    ),
    GetPage(
      name: Routes.custDetails,
      page: () => const CustDetailsView(),
      binding: CustDetailsBindings(),
    ),
    GetPage(
      name: Routes.selectService,
      page: () => const SelectServiceView(),
      binding: SelectServiceBindings(),
    ),
    GetPage(
      name: Routes.paymentScreen,
      page: () => const PaymentScreenView(),
      binding: PaymentScreenBindings(),
    ),
    GetPage(
      name: Routes.confirmationScreen,
      page: () => const ConfirmationScreenView(),
      binding: ConfirmationScreenBindings(),
    ),
    GetPage(
      name: Routes.addserice,
      page: () => const AddServiceView(),
      binding: AddServiceBinding(),
    ),
    GetPage(
      name: Routes.allservices,
      page: () => const AllServicesView(),
      binding: AllServicesBinding(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.personalDetails,
      page: () => const PersonalDetailsView(),
      binding: PersonalDetailsBinding(),
    ),
    GetPage(
      name: Routes.langchange,
      page: () => const LangChangeView(),
      binding: LangChangeBinding(),
    ),
  ];
}
