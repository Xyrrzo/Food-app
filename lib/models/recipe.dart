class Recipe {
  final String title;
  final String? ingredients;
  final String? servings;
  final String? instructions;
  String? imageUrl;  // Made mutable so we can assign images after fetch

  Recipe({
    required this.title,
    this.ingredients,
    this.servings,
    this.instructions,
    this.imageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? 'Unknown Recipe',
      ingredients: json['ingredients'],
      servings: json['servings'],
      instructions: json['instructions'],
      imageUrl: json['image_url'],  // API Ninjas may not return this
    );
  }

  List<String> get ingredientsList {
    if (ingredients == null || ingredients!.isEmpty) return [];
    return ingredients!.split('|').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
  }
}