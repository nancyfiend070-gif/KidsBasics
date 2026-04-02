import 'package:get/get.dart';
import '../../constants/app_routes.dart';
import '../../pages/home/home_page.dart';
import '../../pages/settings/settings_page.dart';
import '../../pages/monetization/ad_demo_page.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(name: AppRoutes.initial, page: () => const HomePage()),
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsPage()),
    GetPage(name: AppRoutes.adDemo, page: () => const AdDemoPage()),
  ];
}
