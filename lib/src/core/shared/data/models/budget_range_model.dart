/// id : 2
/// name : "500.000 : 1.000.000 ﷼"
/// amount_from : "500000.00"
/// amount_to : "1000000.00"
/// order : 2

class BudgetRangeModel {
  BudgetRangeModel({
    this.id,
    this.name,
    this.amountFrom,
    this.amountTo,
    this.order,
  });

  BudgetRangeModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    amountFrom = json['amount_from'];
    amountTo = json['amount_to'];
    order = json['order'];
  }
  num? id;
  String? name;
  String? amountFrom;
  String? amountTo;
  num? order;
  BudgetRangeModel copyWith({
    num? id,
    String? name,
    String? amountFrom,
    String? amountTo,
    num? order,
  }) => BudgetRangeModel(
    id: id ?? this.id,
    name: name ?? this.name,
    amountFrom: amountFrom ?? this.amountFrom,
    amountTo: amountTo ?? this.amountTo,
    order: order ?? this.order,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['amount_from'] = amountFrom;
    map['amount_to'] = amountTo;
    map['order'] = order;
    return map;
  }
}
