class Flashcard {
  final String id;
  final String question;
  final String answer;
  final int createdAt;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  Flashcard copyWith({String? question, String? answer}) {
    return Flashcard(
      id: id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question,
        'answer': answer,
        'createdAt': createdAt,
      };

  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
        id: json['id'],
        question: json['question'],
        answer: json['answer'],
        createdAt: json['createdAt'],
      );
}
