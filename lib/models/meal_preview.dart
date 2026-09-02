class MealPreview {
  final String id;
  final String name;
  final String imageUrl;

  MealPreview({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory MealPreview.fromJson(Map<String, dynamic> json) {
    return MealPreview(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      imageUrl: json['strMealThumb'] ?? '',
    );
  }
}
