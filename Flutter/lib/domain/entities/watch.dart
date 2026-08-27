class Watch {
  const Watch({
    required this.id,
    required this.make,
    required this.model,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  final String id;
  final String make;
  final String model;
  final int price;
  final String currency;
  final String imageUrl;
}
