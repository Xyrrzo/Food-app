import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/category.dart';
import '../models/meal_preview.dart';
import '../models/meal.dart';

class MealDBService {
  static String get _apiKey => dotenv.env['MEALDB_API_KEY'] ?? '1';
  static String get baseUrl => 'https://www.themealdb.com/api/json/v1/$_apiKey';

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List categories = data['categories'] ?? [];
      return categories.map((c) => Category.fromJson(c)).toList();
    }
    throw Exception('Failed to load categories');
  }

  static Future<List<String>> getAreas() async {
    final response = await http.get(Uri.parse('$baseUrl/list.php?a=list'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => m['strArea'] as String).toList();
    }
    throw Exception('Failed to load areas');
  }

  static Future<List<MealPreview>> getMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filter.php?c=$category'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => MealPreview.fromJson(m)).toList();
    }
    throw Exception('Failed to load meals');
  }

  static Future<List<MealPreview>> getMealsByArea(String area) async {
    final response = await http.get(
      Uri.parse('$baseUrl/filter.php?a=$area'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => MealPreview.fromJson(m)).toList();
    }
    throw Exception('Failed to load meals');
  }

  static Future<List<MealPreview>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search.php?s=$query'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return meals.map((m) => MealPreview.fromJson(m)).toList();
    }
    throw Exception('Failed to search meals');
  }

  static Future<Meal> getRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return Meal.fromJson(meals.first);
    }
    throw Exception('Failed to load random meal');
  }

  static Future<Meal> getMealById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List meals = data['meals'] ?? [];
      return Meal.fromJson(meals.first);
    }
    throw Exception('Failed to load meal details');
  }
}
