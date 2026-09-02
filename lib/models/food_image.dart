class FoodImage {
  final String imageUrl;

  FoodImage({required this.imageUrl});

  factory FoodImage.fromJson(Map<String, dynamic> json) {
    return FoodImage(
      imageUrl: json['image'] ?? '',
    );
  }
}
