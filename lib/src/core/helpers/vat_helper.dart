class VatHelper {
  static const double vatPercentage = 15;

  static double priceBeforeVat(double totalPrice) {
    return double.parse(
      (totalPrice / (1 + vatPercentage / 100)).toStringAsFixed(2),
    );
  }

  static double vatAmount(double basePrice) {
    return double.parse((basePrice * vatPercentage / 100).toStringAsFixed(2));
  }

  static double totalWithVat(double basePrice) {
    return double.parse((basePrice + vatAmount(basePrice)).toStringAsFixed(2));
  }
}
