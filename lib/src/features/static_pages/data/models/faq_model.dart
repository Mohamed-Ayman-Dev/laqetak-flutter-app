class FaqModel {
  FaqModel({this.id, this.question, this.answer});

  FaqModel.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

  num? id;
  String? question;
  String? answer;

  FaqModel copyWith({num? id, String? question, String? answer}) => FaqModel(
    id: id ?? this.id,
    question: question ?? this.question,
    answer: answer ?? this.answer,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}
