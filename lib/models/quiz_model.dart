class QuizModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String? image;
  final String? audio;

  const QuizModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.image,
    this.audio,
  });
}
