import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/index.dart';
import '../../core/theme/app_text_styles.dart';
import '../../monetization/ad_manager.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/ads/bottom_banner_ad.dart';

class AdDemoPage extends StatelessWidget {
  const AdDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = Get.find<AdManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Demo'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.l),
              child: Text(
                'This screen demonstrates banner + interstitial + purchase.',
                style: AppTextStyles.subtitleMedium(context),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSizes.m),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.l),
              child: Column(
                children: [
                  AnimatedButton(
                    text: 'Enable Ads (first action)',
                    color: Colors.blue,
                    onTap: () {
                      manager.onUserAction();
                    },
                  ),
                  const SizedBox(height: AppSizes.m),
                  AnimatedButton(
                    text: 'Show Interstitial',
                    color: Colors.green,
                    onTap: () async {
                      await manager.showInterstitialIfReady();
                    },
                  ),
                  const SizedBox(height: AppSizes.m),
                  AnimatedButton(
                    text: 'Remove Ads ₹99',
                    color: Colors.purple,
                    onTap: () async {
                      await manager.startRemoveAdsPurchase();
                    },
                  ),
                  const SizedBox(height: AppSizes.m),
                  AnimatedButton(
                    text: 'Restore Purchases',
                    color: Colors.orange,
                    onTap: () async {
                      await manager.restorePurchases();
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            const BottomBannerAd(),
          ],
        ),
      ),
    );
  }
}

