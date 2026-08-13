import 'package:flutter/cupertino.dart';

import '../data/models/budget_range_model.dart';
import '../data/models/category_model.dart';
import '../data/models/details_model.dart';
import '../data/models/payment_method_model.dart';

class Others with ChangeNotifier {
  List<DetailsModel>? myRegions;
  List<DetailsModel>? mySectors;
  List<BudgetRangeModel>? myBudgetRanges;
  List<PaymentMethodModel>? myPaymentMethods;
  List<CategoryModel>? myCategories;
  List<DetailsModel>? myCities;

  void setCities(List<DetailsModel> cities) {
    myCities = cities;
    notifyListeners();
  }

  void setRegions(List<DetailsModel> regions) {
    myRegions = regions;
    notifyListeners();
  }

  void setCategories(List<CategoryModel> categories) {
    myCategories = categories;
    notifyListeners();
  }

  void setPaymentMethods(List<PaymentMethodModel> paymentMethods) {
    myPaymentMethods = paymentMethods;
    notifyListeners();
  }

  void setSectors(List<DetailsModel> sectors) {
    mySectors = sectors;
    notifyListeners();
  }

  void setBudgetRanges(List<BudgetRangeModel> budgets) {
    myBudgetRanges = budgets;
    notifyListeners();
  }
}
