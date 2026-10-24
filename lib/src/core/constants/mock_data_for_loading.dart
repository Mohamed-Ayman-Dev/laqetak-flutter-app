import '../../../generated/l10n.dart';
import '../shared/others/data/models/details_model.dart';

final class MockDataForLoading {
  MockDataForLoading._();

  static List<DetailsModel> mockPrices = [
    DetailsModel(
      id: 1,
      name: '100.000 : 500.000 ${S.current.sar}',
      key: 100000.toString(),
    ),
    DetailsModel(
      id: 2,
      name: '500.000 : 1.000.000 ${S.current.sar}',
      key: 500000.toString(),
    ),
    DetailsModel(
      id: 3,
      name: ' ${S.current.moreThan} 1.000.000 ${S.current.sar}',
      key: 1000000.toString(),
    ),
  ];
}
