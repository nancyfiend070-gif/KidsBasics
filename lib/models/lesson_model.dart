class LessonModel {
  final String id;
  final String title;
  final String image; // Can be emoji, image path, or URL
  final String audio; // Audio file path (empty if not available)
  final String? description;
  final Map<String, dynamic>? data;

  const LessonModel({
    required this.id,
    required this.title,
    required this.image,
    required this.audio,
    this.description,
    this.data,
  });

  bool get hasImageFile => image.startsWith('assets/') || image.startsWith('http');
  bool get isEmoji => !hasImageFile && image.length <= 2;
}
