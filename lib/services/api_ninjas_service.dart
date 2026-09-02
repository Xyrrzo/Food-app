import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/recipe.dart';


class ApiNinjasService {
  static const String _baseUrl = 'https://api.api-ninjas.com/v1';

  static String get _apiKey {
    final key = dotenv.env['API_NINJAS_KEY'];
    if (key == null || key.isEmpty || key == 'YOUR_API_NINJAS_KEY_HERE') {
      throw Exception(
        'API_NINJAS_KEY not found in .env file.\n'
        '1. Get a free key at https://api-ninjas.com/api/recipe\n'
        '2. Add to .env: API_NINJAS_KEY=your_key_here',
      );
    }
    return key;
  }

  /// Search recipes and assign images based on title keywords
  static Future<List<Recipe>> searchRecipes(String query) async {
    final uri = Uri.parse('$_baseUrl/recipe?query=$query');
    final response = await http.get(
      uri,
      headers: {'X-Api-Key': _apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final recipes = data.map((json) => Recipe.fromJson(json)).toList();

      // Assign images based on recipe title keywords
      for (var recipe in recipes) {
        recipe.imageUrl = _getImageForRecipe(recipe.title);
      }
      return recipes;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key. Check your .env file.');
    } else {
      throw Exception('Failed to search recipes: ${response.statusCode}');
    }
  }

  /// Map recipe title to a Foodish image URL
  static String _getImageForRecipe(String title) {
    final lower = title.toLowerCase();

    // Map keywords to Foodish categories
    if (lower.contains('burger')) {
      return 'https://foodish-api.herokuapp.com/images/burger/burger1.jpg';
    } else if (lower.contains('pizza')) {
      return 'https://foodish-api.herokuapp.com/images/pizza/pizza1.jpg';
    } else if (lower.contains('pasta') || lower.contains('spaghetti') || lower.contains('noodle')) {
      return 'https://foodish-api.herokuapp.com/images/pasta/pasta1.jpg';
    } else if (lower.contains('biryani') || lower.contains('rice')) {
      return 'https://foodish-api.herokuapp.com/images/biryani/biryani1.jpg';
    } else if (lower.contains('dosa')) {
      return 'https://foodish-api.herokuapp.com/images/dosa/dosa1.jpg';
    } else if (lower.contains('dessert') || lower.contains('cake') || lower.contains('sweet')) {
      return 'https://foodish-api.herokuapp.com/images/dessert/dessert1.jpg';
    } else if (lower.contains('samosa')) {
      return 'https://foodish-api.herokuapp.com/images/samosa/samosa1.jpg';
    } else if (lower.contains('butter') || lower.contains('chicken') || lower.contains('curry')) {
      return 'https://foodish-api.herokuapp.com/images/butter-chicken/butter-chicken1.jpg';
    } else if (lower.contains('idly') || lower.contains('idli')) {
      return 'https://foodish-api.herokuapp.com/images/idly/idly1.jpg';
    }

    // Default: return a random food image URL pattern
    return 'https://foodish-api.herokuapp.com/images/burger/burger1.jpg';
  }
}