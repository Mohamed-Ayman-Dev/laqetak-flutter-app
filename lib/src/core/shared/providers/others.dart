import 'package:flutter/cupertino.dart';

import '../models/details_model.dart';

class Others with ChangeNotifier {
  List<DetailsModel>? myRegions;
  List<DetailsModel>? myCities;

  void setCities(List<DetailsModel> cities) {
    myCities = cities;
    notifyListeners();
  }

  void setRegions(List<DetailsModel> regions) {
    myRegions = regions;
    notifyListeners();
  }
}
