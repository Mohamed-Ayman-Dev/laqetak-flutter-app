

class BottomUtils {
  // static showFilterBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //     ),
  //     builder: (context) {
  //       return FiltersBottom();
  //     },
  //   );
  // }
  //
  // static showDeleteBottomSheet(
  //   BuildContext context, {
  //   CartProductModel? cartProduct,
  //
  //   num? id,
  // }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return DeleteBottom(cartProduct: cartProduct, id: id);
  //     },
  //   );
  // }
  //
  // static showLogOutBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return LogOutBottom();
  //     },
  //   );
  // }
  //
  //
  // static showFilterBottomSheet(
  //   BuildContext context, {
  //   void Function(Map<String, dynamic>)? onFilterSearch,
  // }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return FilterBottom(onFilterSearch: onFilterSearch);
  //     },
  //   );
  // }
  //
  // static showGuestBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return GuestBottom();
  //     },
  //   );
  // }
  //
  // static showComplaintBottomSheet(BuildContext context, {num? requestId}) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return ComplaintBottom(requestId: requestId);
  //     },
  //   );
  // }
  //
  // static showEditOrderBottomSheet(
  //   BuildContext context, {
  //   // New: pass the full request and the index of the item to edit
  //   required RequestModel request,
  //   int? itemIndex,
  // }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return EditOrderBottom(request: request, itemIndex: itemIndex);
  //     },
  //   );
  // }
  //
  // static showAddCarPartBottomSheet(
  //   BuildContext context,
  //   SpareCondition selectedCondition,
  // ) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return AddCarPartBottom(selectedCondition: selectedCondition);
  //     },
  //   );
  // }
  //
  // static showAddAddressBottomSheet(
  //   BuildContext context, {
  //   AddressModel? addressDetails,
  // }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return AddAddressBottom(addressDetails: addressDetails);
  //     },
  //   );
  // }
  //
  // static showSelectAddressBottomSheet(
  //   BuildContext context, {
  //   AddressModel? selectedAddress,
  // }) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     constraints: BoxConstraints(
  //       maxHeight: MediaQuery.of(context).size.height * 0.8,
  //     ),
  //     clipBehavior: Clip.antiAlias,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     routeSettings: RouteSettings(
  //       name: '/addresses_screen',
  //       arguments: {
  //         'selectedAddress': selectedAddress,
  //         'isSelectAddress': true,
  //       },
  //     ),
  //     builder: (context) {
  //       return AddressesScreen();
  //     },
  //   );
  // }
  //
  // static showAddCarBottomSheet(BuildContext context, {CarModel? carDetails}) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return AddCarBottom(carDetails: carDetails);
  //     },
  //   );
  // }
  //
  // static showInvoiceBottomSheet(BuildContext context, {InvoiceModel? invoice}) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return InvoiceBottom(invoice: invoice);
  //     },
  //   );
  // }
  //
  // static showMyCarsBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return CarsBottom();
  //     },
  //   );
  // }
  //
  // static showSelectCarsBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     constraints: BoxConstraints(
  //       maxHeight: MediaQuery.of(context).size.height * 0.8,
  //     ),
  //     clipBehavior: Clip.antiAlias,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return CarsBottom();
  //     },
  //   );
  // }
  //
  // static showLangBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return LangBottom();
  //     },
  //   );
  // }
  //
  // static showLogOutBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //     builder: (context) {
  //       return LogOutBottom();
  //     },
  //   );
  // }
}
