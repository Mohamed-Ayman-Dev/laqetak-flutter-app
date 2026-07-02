class VatHelper {
  static const double vatPercentage = 15;

  static double priceBeforeVat(double totalPrice) {
    return double.parse(
      (totalPrice / (1 + vatPercentage / 100)).toStringAsFixed(2),
    );
  }

  static double vatAmount(double totalPrice) {
    return double.parse(
      (totalPrice - priceBeforeVat(totalPrice)).toStringAsFixed(2),
    );
  }
}
