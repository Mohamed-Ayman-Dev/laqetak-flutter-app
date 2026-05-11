import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/shared/models/details_model.dart';

final class MockDataForLoading {
  MockDataForLoading._();

  static List<DetailsModel> mockCites = [
    DetailsModel(id: 1, name: 'الرياض'),
    DetailsModel(id: 2, name: 'جدة'),
  ];
  static List<Map<String, dynamic>> mockAds = [
    {
      'image': ImagesAssets.assetsImagesMockAd1,
      'label': 'مشروع تجاري كامل',
      'name': 'محمد الدوسري',
      'location': 'الرياض',
      'category': 'عقاري',
      'price': "50,000",
      'time': "1 ساعة",
    },
    {
      'image': ImagesAssets.assetsImagesMockAd2,
      'label': 'عمارة سكنية',
      'name': 'محمد الدوسري',
      'location': 'الرياض',
      'category': 'عقاري',
      'price': "24,000",
      'time': "1 ساعة",
    },
    {
      'image': ImagesAssets.assetsImagesMockAd3,
      'label': 'مشروع تجاري كامل',
      'name': 'محمد الدوسري',
      'location': 'الرياض',
      'category': 'عقاري',
      'price': "50,000",
      'time': "1 ساعة",
    },
    {
      'image': ImagesAssets.assetsImagesMockAd4,
      'label': 'مطعم مربح وكامل',
      'name': 'محمد الدوسري',
      'location': 'الرياض',
      'category': 'عقاري',
      'price': "43,000",
      'time': "1 ساعة",
    },
    {
      'image': ImagesAssets.assetsImagesMockAd5,
      'label': 'مشروع تجاري كامل',
      'name': 'محمد الدوسري',
      'location': 'الرياض',
      'category': 'عقاري',
      'price': "30,000",
      'time': "1 ساعة",
    },
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
