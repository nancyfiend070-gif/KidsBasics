import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../monetization/ad_manager.dart';

/// Banner ad fixed at bottom of the screen layout (safe & kid-friendly).
///
/// Production rule:
/// - Do NOT reuse the same BannerAd instance in more than one AdWidget.
/// - So we create/load the BannerAd INSIDE this widget (per instance),
///   while `AdManager` only controls whether banners are allowed/removed.
class BottomBannerAd extends StatelessWidget {
  const BottomBannerAd({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AdManager>(
      builder: (manager) {
        final isCurrentRoute = ModalRoute.of(context)?.isCurrent ?? true;
        if (!isCurrentRoute) return const SizedBox.shrink();
        if (!manager.shouldShowBanner) return const SizedBox.shrink();

        return SizedBox(
          height: manager.bannerHeight,
          width: double.infinity,
          child: const _LocalBannerAd(),
        );
      },
    );
  }
}

class _LocalBannerAd extends StatefulWidget {
  const _LocalBannerAd();

  @override
  State<_LocalBannerAd> createState() => _LocalBannerAdState();
}

class _LocalBannerAdState extends State<_LocalBannerAd> {
  BannerAd? _bannerAd;
  bool _isFailed = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    final unitId = AdManager.testBannerAdUnitId;
    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: unitId,
      size: AdSize.banner,
      request: const AdRequest(nonPersonalizedAds: true),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          setState(() => _isFailed = true);
          ad.dispose();
          _bannerAd = null;
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFailed) return const SizedBox.shrink();
    if (_bannerAd == null) return const SizedBox.shrink();
    return AdWidget(ad: _bannerAd!);
  }
}

