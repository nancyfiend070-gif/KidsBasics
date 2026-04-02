import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_pages.dart';
import 'constants/app_strings.dart';
import 'constants/app_routes.dart';
import 'controllers/theme_controller.dart';
import 'services/app_audio_session.dart';
import 'services/audio_service.dart';
import 'services/tts_service.dart';
import 'monetization/ad_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAppAudioSession();
  Get.put(ThemeController());
  Get.put(AudioService());
  Get.put(TtsService());
  Get.put(AdManager());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      if (Get.isRegistered<AudioService>()) {
        Get.find<AudioService>().stopAllForBackground();
      }
      if (Get.isRegistered<TtsService>()) {
        final tts = Get.find<TtsService>();
        tts.stop();
        tts.clearCaption();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode.value,
      initialRoute: AppRoutes.initial,
      getPages: AppPages.routes,
    ));
  }
}