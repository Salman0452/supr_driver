import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supr_driver/screens/auth/phone_verification_screen.dart';
import 'package:supr_driver/screens/splash_screen.dart';
import 'package:supr_driver/screens/onboarding_screen.dart';
import 'package:supr_driver/screens/auth/register_screen.dart';
import 'package:supr_driver/screens/auth/password_register_screen.dart';
import 'package:supr_driver/screens/documents/vehicle_info.dart';
import 'package:supr_driver/screens/documents/license_upload.dart';
import 'package:supr_driver/screens/documents/license_preview.dart';
import 'package:supr_driver/screens/documents/licensePlate_upload.dart';
import 'package:supr_driver/screens/documents/licensePlate_preview.dart';
import 'package:supr_driver/screens/documents/vehicleInsurance_upload.dart';
import 'package:supr_driver/screens/documents/vehicleInsurance_preview.dart';
import 'package:supr_driver/screens/documents/profile_upload.dart';
import 'package:supr_driver/screens/documents/profile_preview.dart';
import 'package:supr_driver/screens/documents/documents-uploaded_screen.dart';

import 'package:supr_driver/screens/bottom_nav_screen.dart';
import 'package:supr_driver/screens/dashboard_screen.dart';


import 'package:supr_driver/screens/auth/login_screen.dart';
import 'package:supr_driver/screens/auth/phone_verification_screen.dart';
import 'package:supr_driver/screens/auth/forgot_password_screen.dart';
import 'package:supr_driver/screens/auth/reset_password_screen.dart';
import 'package:supr_driver/screens/auth/password_changed_screen.dart';

import 'package:supr_driver/screens/settings/notification_screen.dart';
import 'package:supr_driver/screens/settings/payment_method_screen.dart';
import 'package:supr_driver/screens/settings/working_hours_screen.dart';
import 'package:supr_driver/screens/settings/service_area.dart';
import 'package:supr_driver/screens/settings/store_details_screen.dart';
import 'package:supr_driver/screens/settings/edit_store_details.dart';
import 'package:supr_driver/screens/settings/support_chat_screen.dart';
import 'package:supr_driver/screens/settings/appeal_screen.dart';
import 'package:supr_driver/screens/settings/privacy_policy_screen.dart';
import 'package:supr_driver/screens/settings/help_screen.dart';
import 'package:supr_driver/screens/settings/profile_screen.dart';
import 'package:supr_driver/screens/settings/edit_profile_screen.dart';
import 'package:supr_driver/screens/settings/vehicle_info.dart';
import 'package:supr_driver/screens/settings/job_preference.dart';

import 'package:supr_driver/screens/earnings/withdraw_blnc_screen.dart';
import 'package:supr_driver/screens/earnings/earning_overview.dart';



class Routes {
  static const splashScreen = '/splash';
  static const onboardingScreen = '/onboarding';
  static const registerScreen = '/register';
  static const passwordRegisterScreen = '/passwordRegister';
  static const licenseUploadScreen = '/licenseUploadScreen';
  static const licensePreviewScreen = '/licensePreviewScreen';
  static const licensePlateUploadScreen = '/licensePlateUploadScreen';
  static const licensePlatePreviewScreen = '/licensePlatePreviewScreen';
  static const vehicleInsuranceUpload = '/vehicleInsuranceUpload';
  static const vehicleInsurancePreview = '/vehicleInsurancePreview';
  static const profileUploadScreen = '/profileUploadScreen';
  static const profilePreviewScreen = '/profilePreviewScreen';
  static const documentsUploaded = '/documentsUploaded';


  static const vehicleInfo = '/vehicleInfo';
  static const loginScreen = '/login';
  static const phoneOtp = '/phoneOtp';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const resetPasswordScreen = '/resetPasswordScreen';
  static const passwordChangedScreen = '/passwordChangedScreen';

  static const bottomNavScreen = '/bottomNavScreen';
  static const dashboardScreen = '/dashboardScreen';


  static const supportChat = '/support-chat';
  static const appealScreen = '/appeal-screen';
  static const notificationScreen = '/notificationScreen';
  static const paymentMethodScreen = '/paymentMethodScreen'; 
  static const workingHoursScreen = '/workingHoursScreen'; 
  static const deliveryZone = '/deliveryZone';
  static const storeDetails ='/storeDetails';
  static const editStoreDetails = '/editStoreDetails';
  static const privacyPolicyScreen = '/privacyPolicyScreen';
  static const helpScreen = '/helpScreen';
  static const profileScreen = '/profile';
  static const editProfileScreen = '/edit_profile';
  static const VehicleInfo = '/VehicleInfo';
  static const jobPref = '/jobPref';

  static const withdrawBalanceScreen = '/withdrawBalanceScreen';
  static const earningOverviewScreen = '/earningOverviewScreen';



  static final routes = <GetPage<Widget>>[
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: registerScreen, page: () => RegisterScreen()),
    GetPage(name: licenseUploadScreen, page: () => const LicenseUploadScreen()),
    GetPage(name: licensePreviewScreen, page: () => const LicensePreviewScreen()),
    GetPage(name: licensePlateUploadScreen, page: () => const LicensePlateUploadScreen()),
    GetPage(name: licensePlatePreviewScreen, page: () => const LicensePlatePreviewScreen()),
    GetPage(name: vehicleInsuranceUpload, page: () => const VehicleInsuranceUpload()),
    GetPage(name: vehicleInsurancePreview, page: () => const VehicleInsurancePreview()),
    GetPage(name: profileUploadScreen, page: () => const ProfileUploadScreen()),
    GetPage(name: profilePreviewScreen, page: () => const ProfilePreviewScreen()),
    GetPage(name: documentsUploaded, page: () => const DocumentsUploadedScreen()),


    GetPage(name: vehicleInfo, page: () => VehicleInfoScreen()),
    GetPage(name: passwordRegisterScreen, page: () => const PasswordRegisterScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: phoneOtp, page: () => const PhoneVerificationScreen()),
    GetPage(name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: passwordChangedScreen, page: () => const PasswordChangedScreen()),

    GetPage(name: bottomNavScreen, page: () => const BottomNavScreen()),
    GetPage(name: dashboardScreen, page: () => const DashboardScreen()),

    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: supportChat, page: () => SupportChatScreen(),),
    GetPage(name: appealScreen, page: () => const AppealScreen(),),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: paymentMethodScreen, page: () => const PaymentMethodScreen()), 
    GetPage(name: workingHoursScreen, page: () => const WorkingHoursScreen()), 
    GetPage(name: deliveryZone, page: () => const DeliveryZoneScreen()),
    GetPage(name: storeDetails, page: () => const StoreDetailsScreen()),
    GetPage(name: editStoreDetails, page: () => const EditStoreScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()), 
    GetPage(name: helpScreen, page: () => const HelpScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: VehicleInfo, page: () => const VehicleInfoScreenSettings()),
    GetPage(name: jobPref, page: () => const JobPreferenceScreen()),

    GetPage(name: withdrawBalanceScreen, page: () => const WithdrawBalanceScreen()),
    GetPage(name: earningOverviewScreen, page: () => const EarningOverviewScreen()),

  ];
}
extension RoutesExtension on String {
  void push() {
    Get.toNamed<void>(this);
  }

  void pushReplace() {
    Get.offNamed<void>(this);
  }
}