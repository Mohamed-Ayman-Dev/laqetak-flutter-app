import 'package:flutter/material.dart';

import '../../../../core/shared/models/faq_model.dart';

class StaticPages with ChangeNotifier {
  List<FaqModel>? myFaqs;

  void setFaqs(List<FaqModel> faqs) {
    myFaqs = faqs;
    notifyListeners();
  }
}
