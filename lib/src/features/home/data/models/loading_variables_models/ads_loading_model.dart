class AdsLoadingModel {
  bool loadingAds;
  bool loadingSearch;

  AdsLoadingModel({this.loadingAds = false, this.loadingSearch = false});

  void updateValue(String key, dynamic value) {
    switch (key) {
      case 'loadingAds':
        loadingAds = value;
        break;
      case 'loadingSearch':
        loadingSearch = value;
        break;
    }
  }

  void clear() {
    loadingAds = false;
    loadingSearch = false;
  }
}
