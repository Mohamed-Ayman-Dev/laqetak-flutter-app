class AdsLoadingModel {
  bool loadingAds;

  AdsLoadingModel({this.loadingAds = false});

  void updateValue(String key, dynamic value) {
    switch (key) {
      case 'loadingAds':
        loadingAds = value;
        break;
    }
  }

  void clear() {
    loadingAds = false;
  }
}
