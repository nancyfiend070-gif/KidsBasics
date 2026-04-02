// Sound & feedback rules (PlayABC-style). MP3s live in assets/audio/.
//
// TAP (tap.mp3)
// - Any neutral UI press: buttons, cards, navigation, wrong-but-valid attempts.
// - Keeps the app feeling responsive without a full reward every time.
//
// COIN / CORRECT (coin_pickup.mp3, falls back to reward_star.mp3)
// - Correct answer in a game, collected star/point, successful match.
// - Stronger than tap, weaker than celebration.
//
// REWARD STAR (reward_star.mp3)
// - Repeatable small wins: every N letter taps, mid-lesson star, streak tick.
//
// REWARD CELEBRATION (reward_celebration.mp3)
// - Big moments: finished a round, finished tracing A–Z, quiz complete, major milestone.
//
// TTS ([TtsService], system voice — not MP3)
// - Letters, words, short praise ("Great job!"), instructions.
// - Stopped with [TtsService.stop] when app backgrounds.
//
// CONFETTI (Lottie + optional celebration sound)
// - Trigger confetti with celebration SFX for: final wins, big milestones, quiz completion.
// - Use star/coin SFX for per-question correct without full fanfare every time.

/// Placeholder export so this file can be imported for documentation.
void soundUsageDoc() {}
