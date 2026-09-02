import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_image.dart';

// ============================================
// FOODISH API SERVICE (NO KEY NEEDED)
// ============================================
// Base URL: https://foodish-api.herokuapp.com
// Auth: None required
// Free, no signup needed
//
// ENDPOINTS USED:
//   GET /api/              -> Random food image from any category
//   GET /api/images/burger -> Random burger image
//   GET /api/images/pizza  -> Random pizza image
//
// AVAILABLE CATEGORIES:
//   biryani, burger, butter-chicken, dessert, dosa,
//   idly, pasta, pizza, rice, samosa
//
// RESPONSE FORMAT:
//   {"image": "https://foodish-api.herokuapp.com/images/burger/burger101.jpg"}
// ============================================

class FoodishService {
  static const String _baseUrl = 'https://foodish-api.herokuapp.com/api';

  /// Get a random food image from any category
  static Future<FoodImage> getRandomImage() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return FoodImage.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load random image');
  }

  /// Get a random image from a specific category
  static Future<FoodImage> getImageByCategory(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl/images/$category'));
    if (response.statusCode == 200) {
      return FoodImage.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load image for $category');
  }

  /// Get multiple random images
  static Future<List<FoodImage>> getMultipleImages(int count) async {
    final List<FoodImage> images = [];
    for (int i = 0; i < count; i++) {
      try {
        final img = await getRandomImage();
        images.add(img);
      } catch (e) {
        // Skip failed requests
      }
    }
    return images;
  }

  static const List<String> categories = [
    'biryani',
    'burger',
    'butter-chicken',
    'dessert',
    'dosa',
    'idly',
    'pasta',
    'pizza',
    'rice',
    'samosa',
  ];
}
