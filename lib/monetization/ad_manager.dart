import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Central monetization controller for:
/// - Banner ads (bottom of main screens)
/// - Interstitial ads (after repeated completed actions, not on app open)
/// - In-app purchase: "remove_ads_99" (removes all ads permanently)
///
/// Notes for kids apps:
/// - No interstitial shown on app open.
/// - Banner is shown only after the first user action (to avoid ads on launch).
class AdManager extends GetxController {
  // ----- In-app purchase -----
  static const String productIdRemoveAds = 'remove_ads_99';
  static const String prefsKeyRemovedAds = 'remove_ads_99_purchased';

  // ----- Google Mobile Ads (test units for dev) -----
  static const String testBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';
  static const String testInterstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  /// Banner shows only if:
  /// - user hasn't removed ads
  /// - ads are allowed (after first user action)
  /// - banner is loaded
  final RxBool showBanner = false.obs;
  final RxBool adsRemoved = false.obs;
  final RxBool adsAllowed = false.obs; // set on first tap/click

  // We intentionally do NOT keep a shared BannerAd instance here.
  // Google Mobile Ads requires that the same ad object is NOT attached to
  // multiple AdWidget instances at the same time (this happens if multiple
  // routes stay mounted underneath via GetX navigation).
  InterstitialAd? _interstitialAd;
  bool _interstitialLoading = false;

  /// Interstitial trigger:
  /// show after every 2-3 completed actions (randomly 2 or 3).
  int _completedActions = 0;
  int _nextInterstitialAfter = 2;
  final Random _random = Random();

  // IAP state
  final Set<String> _productIds = {productIdRemoveAds};
  List<ProductDetails>? _productDetailsList;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  double get bannerHeight => AdSize.banner.height.toDouble();

  /// Whether the banner ad widget should be rendered.
  bool get shouldShowBanner => showBanner.value;

  @override
  void onInit() {
    super.onInit();
    _nextInterstitialAfter = _random.nextInt(2) + 2; // 2 or 3
    _init();
  }

  Future<void> _init() async {
    await _loadRemovedAdsState();

    // Required before loading any ads.
    try {
      await MobileAds.instance.initialize();
    } catch (e) {
      if (kDebugMode) debugPrint('AdManager: MobileAds init failed: $e');
    }

    // Initialize interstitial early, but never show it on app open.
    // Banner will load only after [onUserAction()] (adsAllowed == true).
    _loadInterstitial();

    // Listen purchase stream ASAP (recommended by plugin docs).
    _purchaseSubscription = InAppPurchase.instance.purchaseStream.listen(
      _handlePurchaseUpdates,
      onError: (e) {
        if (kDebugMode) debugPrint('AdManager: purchaseStream error: $e');
      },
    );

    await _queryProductDetails();
    _updateShowBanner();
  }

  Future<void> _loadRemovedAdsState() async {
    final prefs = await SharedPreferences.getInstance();
    adsRemoved.value = prefs.getBool(prefsKeyRemovedAds) ?? false;
  }

  Future<void> _queryProductDetails() async {
    try {
      final response =
          await InAppPurchase.instance.queryProductDetails(_productIds);
      _productDetailsList = response.productDetails;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AdManager: queryProductDetails failed: $e');
      }
    }
  }

  Future<void> _handlePurchaseUpdates(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (final purchaseDetails in purchaseDetailsList) {
      final status = purchaseDetails.status;

      if (status == PurchaseStatus.purchased ||
          status == PurchaseStatus.restored) {
        final isRemovedProduct =
            purchaseDetails.productID == productIdRemoveAds;
        if (isRemovedProduct) {
          await _markAdsRemovedPermanently();
        }

        // Always complete purchase.
        try {
          await InAppPurchase.instance
              .completePurchase(purchaseDetails);
        } catch (_) {}
      } else if (status == PurchaseStatus.error) {
        if (kDebugMode) {
          debugPrint(
            'AdManager: purchase error: ${purchaseDetails.error}',
          );
        }
      } else {
        // pending / unspecified handled by plugin via purchaseStream updates
      }
    }
  }

  Future<void> _markAdsRemovedPermanently() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefsKeyRemovedAds, true);
    adsRemoved.value = true;
    adsAllowed.value = false; // stop showing banner immediately
    _disposeInterstitial();
    _updateShowBanner();
  }

  /// Call on any meaningful user tap/interaction.
  /// After first action, we allow banner ads (but still respect remove-ads state).
  void onUserAction() {
    if (adsRemoved.value) return;
    if (!adsAllowed.value) {
      adsAllowed.value = true;
      _updateShowBanner();
    }
  }

  void onActivityCompleted({bool major = false}) {
    if (adsRemoved.value) return;

    // Keep it simple & kid-safe:
    // we only trigger interstitial on completion milestones.
    _completedActions++;

    final shouldShow = _completedActions >= _nextInterstitialAfter;
    if (!shouldShow) return;

    _completedActions = 0;
    _nextInterstitialAfter = _random.nextInt(2) + 2; // 2 or 3 again

    if (major) {
      // Still respect the "not on app open" rule.
      // For major wins, show immediately when loaded.
      showInterstitialIfReady();
    } else {
      showInterstitialIfReady();
    }
  }

  Future<void> showInterstitialIfReady() async {
    if (adsRemoved.value) return;
    if (!adsAllowed.value) return; // avoid any ad on app launch
    final ad = _interstitialAd;
    if (ad == null) {
      // Interstitial not ready yet; ensure we load next.
      _loadInterstitial();
      return;
    }

    _interstitialAd = null;

    try {
      await ad.show();
    } catch (e) {
      if (kDebugMode) debugPrint('AdManager: interstitial show failed: $e');
      _loadInterstitial();
    }

    // Always load the next one after show.
    _loadInterstitial();
  }

  void _loadInterstitial() {
    if (adsRemoved.value) return;
    if (_interstitialLoading) return;

    _interstitialLoading = true;

    InterstitialAd.load(
      adUnitId: testInterstitialAdUnitId,
      request: const AdRequest(nonPersonalizedAds: true),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialLoading = false;
          if (kDebugMode) {
            debugPrint('AdManager: interstitial loaded');
          }
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _interstitialLoading = false;
          if (kDebugMode) {
            debugPrint('AdManager: interstitial failed: $error');
          }
        },
      ),
    );
  }

  void _disposeInterstitial() {
    try {
      _interstitialAd?.dispose();
    } catch (_) {}
    _interstitialAd = null;
  }

  void _updateShowBanner() {
    final canShow = adsAllowed.value && !adsRemoved.value;
    showBanner.value = canShow;
  }

  /// ----- Purchase API -----

  Future<void> startRemoveAdsPurchase() async {
    if (adsRemoved.value) return;

    if (_productDetailsList == null) {
      await _queryProductDetails();
    }

    ProductDetails? productDetails;
    for (final p in _productDetailsList ?? const <ProductDetails>[]) {
      if (p.id == productIdRemoveAds) {
        productDetails = p;
        break;
      }
    }
    if (productDetails == null) return;

    final param = PurchaseParam(productDetails: productDetails);
    await InAppPurchase.instance
        .buyNonConsumable(purchaseParam: param);
    // Purchase result arrives via [_handlePurchaseUpdates].
  }

  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
    // Restored results arrive via [_handlePurchaseUpdates].
  }

  @override
  void onClose() {
    _purchaseSubscription?.cancel();
    _disposeInterstitial();
    super.onClose();
  }
}

