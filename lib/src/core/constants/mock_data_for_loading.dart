import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/shared/models/details_model.dart';

final class MockDataForLoading {
  MockDataForLoading._();

  static List<DetailsModel> mockCites = [
    DetailsModel(id: 1, name: 'الرياض'),
    DetailsModel(id: 2, name: 'جدة'),
  ];
  static List<String> mockAds = [
    ImagesAssets.assetsImagesMockAd1,
    ImagesAssets.assetsImagesMockAd2,
    ImagesAssets.assetsImagesMockAd3,
    ImagesAssets.assetsImagesMockAd4,
    ImagesAssets.assetsImagesMockAd5,
  ];

  // static const ServiceModel _mockServiceModel = ServiceModel(
  //   id: 1,
  //   isFavorite: false,
  //   mainImage: 'https://example.com/image.jpg',
  //   vendorName: 'Example Vendor',
  //   rate: 5,
  //   price: '100.00',
  // );
  // static List<ServiceModel> mockServices = const [
  //   _mockServiceModel,
  //   _mockServiceModel,
  //   _mockServiceModel,
  //   _mockServiceModel,
  // ];
  // static const OrderModel _mockOrderModel = OrderModel(
  //   id: 1,
  //   status: 'Pending',
  //   date: '2023-10-01',
  //   time: '14:00:00',
  // );
  // static List<OrderModel> mockOrders = const [
  //   _mockOrderModel,
  //   _mockOrderModel,
  //   _mockOrderModel,
  //   _mockOrderModel,
  // ];
  // static const NotificationModel _mockNotification = NotificationModel(
  //   id: '4',
  //   title: 'Notification Title',
  //   orderId: 4,
  //   body: 'Notification Body',
  // );
  //
  // static List<NotificationModel> mockNotifications = const [
  //   _mockNotification,
  //   _mockNotification,
  //   _mockNotification,
  // ];
  // static const VendorOrderModel _vendorOrder = VendorOrderModel(
  //   id: 1,
  //   status: 'Pending',
  //   date: '2023-10-01',
  //   time: '10:00 AM',
  // );
  //
  // static List<VendorOrderModel> mockVendorOrders = const [
  //   _vendorOrder,
  //   _vendorOrder,
  //   _vendorOrder,
  //   _vendorOrder,
  // ];
  // static const ConversationModel _mockConversation = ConversationModel(
  //   orderId: '4',
  //   id: 1,
  //   lastMessage: 'Hello, how can I help you today?',
  //   lastMessageTime: '2023-10-01 10:00:00',
  // );
  //
  // static List<ConversationModel> mockConversations = const [
  //   _mockConversation,
  //   _mockConversation,
  //   _mockConversation,
  //   _mockConversation,
  // ];
}
