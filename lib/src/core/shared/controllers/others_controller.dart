abstract class OthersController {
  /// Get list of cities
  /// Returns list of cities on success
  static Future<void> getCities({bool showLoading = false}) async {
    // if (showLoading) {
    //   EasyLoading.show(status: S.current.pleaseWait);
    // }
    // try {
    //   final response = await LocatorService.addressService.getCities(
    //     rethrowError: true,
    //   );
    //   LocatorService.addresses.setCities(
    //     response['data']
    //         .map<DetailsModel>((e) => DetailsModel.fromJson(e))
    //         .toList(),
    //   );
    // } catch (e) {
    //   ApiService.handleApiError(e);
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
  }

  static Future<void> getRegions() async {
    // try {
    //   final response = await LocatorService.addressService.getRegions(
    //     rethrowError: true,
    //   );
    //   LocatorService.addresses.setRegions(
    //     response['data']
    //         .map<DetailsModel>((e) => DetailsModel.fromJson(e))
    //         .toList(),
    //   );
    // } catch (e) {
    //   ApiService.handleApiError(e);
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }
  }
}
