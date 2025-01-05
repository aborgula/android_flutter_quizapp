import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int? questionsCount;

  // Konstruktor
  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questionsCount,
    this.questions, // może być null
  });

  // Konstruktor z JSON
  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String? ?? 'Default ID', // domyślna wartość, jeśli null
        title = json['title'] as String? ?? 'Default Title', // domyślna wartość, jeśli null
        imageUrl = json['image_url'] as String?, // jeśli null, to pozostaje null
        description = json['description'] as String? ?? 'Default Description', // domyślna wartość, jeśli null
        timeSeconds = json['time_seconds'] as int? ?? 0, // domyślna wartość, jeśli null
        questionsCount = 0,
        questions = (json['questions'] as List?)
            ?.map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList(); // obsługuje null w liście


  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['description'],
        timeSeconds = json['time_seconds'],
        questionsCount = json['questions_count'] as int,
        questions = [];

  String timeInMinits() => "${(timeSeconds/60).ceil()}";

  // Konwersja na JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl; // może być null
    data['description'] = this.description;
    data['time_seconds'] = this.timeSeconds;
    return data;
  }

  @override
  String toString() {
    return 'QuestionPaperModel{id: $id, title: "$title", imageUrl: "$imageUrl", description: "$description", timeSeconds: $timeSeconds, questions: $questions}';
  }

}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  // Konstruktor
  Questions({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer, // może być null
  });

  // Konstruktor z JSON
  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String? ?? 'Default ID', // domyślna wartość, jeśli null
        question = json['question'] as String? ?? 'Default Question', // domyślna wartość, jeśli null
        answers = (json['answers'] as List)
            .map((e) => Answers.fromJson(e as Map<String, dynamic>))
            .toList(),
        correctAnswer = json['correct_answer'] as String?;


  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
  :id=snapshot.id,
  question = snapshot['question'],
  answers = [],
  correctAnswer = snapshot['correct_answer'];


  // Konwersja na JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answers'] = this.answers.map((v) => v.toJson()).toList();
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  // Konstruktor
  Answers({this.identifier, this.answer});

  // Konstruktor z JSON
  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'] as String?,
        answer = json['answer'] as String?;

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;


  // Konwersja na JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['answer'] = this.answer;
    return data;
  }


}