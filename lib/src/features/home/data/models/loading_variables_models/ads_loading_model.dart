class AdsLoadingModel {
  bool loadingAds;
  bool loadingSearch;
  bool loadingFavAds;

  AdsLoadingModel({
    this.loadingAds = false,
    this.loadingSearch = false,
    this.loadingFavAds = false,
  });

  void updateValue(String key, dynamic value) {
    switch (key) {
      case 'loadingAds':
        loadingAds = value;
        break;
      case 'loadingSearch':
        loadingSearch = value;
        break;
      case 'loadingFavAds':
        loadingFavAds = value;
        break;
    }
  }

  void clear() {
    loadingAds = false;
    loadingSearch = false;
    loadingFavAds = false;
  }
}
