import 'package:audio_session/audio_session.dart';

/// Call once at startup (before [runApp]) so BGM/SFX/TTS can share the session.
Future<void> configureAppAudioSession() async {
  final session = await AudioSession.instance;
  const base = AudioSessionConfiguration.music();
  await session.configure(
    base.copyWith(
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.mixWithOthers,
    ),
  );
}
