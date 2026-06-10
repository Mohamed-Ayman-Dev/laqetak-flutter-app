/// id : 1
/// question : "Omnis similique error esse iure odio pariatur.?"
/// answer : "Ut dicta autem consectetur quo vitae iure. Et sapiente et et ipsum ut. Est voluptatum rerum esse voluptate aut veniam eaque ipsa. Corrupti aut ut aperiam voluptas in vel ducimus. Ipsum optio perspiciatis neque cumque non."

class FaqModel {
  FaqModel({
      this.id, 
      this.question, 
      this.answer,});

  FaqModel.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
  num? id;
  String? question;
  String? answer;
FaqModel copyWith({  num? id,
  String? question,
  String? answer,
}) => FaqModel(  id: id ?? this.id,
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