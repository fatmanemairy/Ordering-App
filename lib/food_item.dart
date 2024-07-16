class FoodItem {
  final String foodName;
  final int calories;
  final double price;
  final String imageUrl;
  int quantity;

  FoodItem({
    required this.foodName,
    required this.calories,
    required this.price,
    required this.imageUrl,
    this.quantity = 0,
  });
}