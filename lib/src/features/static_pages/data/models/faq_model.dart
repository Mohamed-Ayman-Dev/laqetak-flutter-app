/// id : 1
/// category : "Test1"
/// application : "customer"
/// faqs : [{"id":1,"question":"TestTestTestTestTest","answer":"TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest"}]

class FaqModel {
  FaqModel({this.id, this.category, this.application, this.faqs});

  FaqModel.fromJson(dynamic json) {
    id = json['id'];
    category = json['category'];
    application = json['application'];
    if (json['faqs'] != null) {
      faqs = [];
      json['faqs'].forEach((v) {
        faqs?.add(Faqs.fromJson(v));
      });
    }
  }
  num? id;
  String? category;
  String? application;
  List<Faqs>? faqs;
  FaqModel copyWith({
    num? id,
    String? category,
    String? application,
    List<Faqs>? faqs,
  }) => FaqModel(
    id: id ?? this.id,
    category: category ?? this.category,
    application: application ?? this.application,
    faqs: faqs ?? this.faqs,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category'] = category;
    map['application'] = application;
    if (faqs != null) {
      map['faqs'] = faqs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// question : "TestTestTestTestTest"
/// answer : "TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest"

class Faqs {
  Faqs({this.id, this.question, this.answer});

  Faqs.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
  num? id;
  String? question;
  String? answer;
  Faqs copyWith({num? id, String? question, String? answer}) => Faqs(
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
