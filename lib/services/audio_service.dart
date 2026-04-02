import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Central MP3/WAV playback for sound effects only (tap, rewards, coin).
/// Files under `assets/audio/` — prefer `.mp3`, then `.wav` fallback.
class AudioService extends GetxController {
  static AudioService get to => Get.find();

  late final AudioPlayer _sfxPlayer;

  bool _sessionAndPlayersReady = false;

  @override
  void onInit() {
    super.onInit();
    _sfxPlayer = AudioPlayer();
  }

  @override
  void onClose() {
    _sfxPlayer.dispose();
    super.onClose();
  }

  Future<void> _ensureReady() async {
    if (_sessionAndPlayersReady) return;
    final ctx = AudioContextConfig(
      focus: AudioContextConfigFocus.mixWithOthers,
    ).build();
    await _sfxPlayer.setAudioContext(ctx);
    await _sfxPlayer.setPlayerMode(PlayerMode.lowLatency);
    _sessionAndPlayersReady = true;
  }

  Future<String?> _firstExistingAsset(List<String> fileNames) async {
    for (final name in fileNames) {
      try {
        await rootBundle.load('assets/audio/$name');
        return name;
      } catch (_) {}
    }
    return null;
  }

  Future<bool> _playFromCandidates(
    List<String> fileNames, {
    ReleaseMode releaseMode = ReleaseMode.stop,
    double volume = 1.0,
  }) async {
    await _ensureReady();
    final name = await _firstExistingAsset(fileNames);
    if (name == null) {
      if (kDebugMode) {
        debugPrint(
          'AudioService: none of these exist under assets/audio/: $fileNames',
        );
      }
      return false;
    }
    try {
      await _sfxPlayer.stop();
      await _sfxPlayer.setReleaseMode(releaseMode);
      await _sfxPlayer.setVolume(volume);
      await _sfxPlayer.play(AssetSource('audio/$name'));
      if (kDebugMode) {
        debugPrint('AudioService: OK — playing audio/$name');
      }
      return true;
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('AudioService: play failed for audio/$name — $e');
        debugPrint('$st');
      }
      return false;
    }
  }

  Future<void> playTap() => _playSfx(AudioAssetCandidates.tap);

  Future<void> playRewardStar() => _playSfx(AudioAssetCandidates.rewardStar);

  Future<void> playRewardCelebration() => _playSfx(AudioAssetCandidates.rewardCelebration);

  Future<void> playCoinPickup() async {
    await _playFromCandidates(
      [
        ...AudioAssetCandidates.coinPickup,
        ...AudioAssetCandidates.rewardStar,
      ],
      releaseMode: ReleaseMode.stop,
      volume: 1.0,
    );
  }

  Future<void> _playSfx(List<String> candidates) async {
    await _playFromCandidates(
      candidates,
      releaseMode: ReleaseMode.stop,
      volume: 1.0,
    );
  }

  /// Stop SFX when app is not active (does not apply to TTS — see [TtsService]).
  Future<void> stopAllForBackground() async {
    try {
      await _sfxPlayer.stop();
    } catch (_) {}
  }

  Future<void> stopAllAudio() async {
    try {
      await _sfxPlayer.stop();
    } catch (_) {}
  }

  Future<bool> verifyTapSound() async {
    return _playFromCandidates(
      AudioAssetCandidates.tap,
      releaseMode: ReleaseMode.stop,
      volume: 1.0,
    );
  }
}

abstract final class AudioAssetCandidates {
  static const List<String> tap = ['tap.mp3', 'tap.wav'];
  static const List<String> rewardStar = ['reward_star.mp3', 'reward_star.wav'];
  static const List<String> rewardCelebration = [
    'reward_celebration.mp3',
    'reward_celebration.wav',
  ];
  static const List<String> coinPickup = ['coin_pickup.mp3', 'coin_pickup.wav'];
}
