import '../services/meal_db_service.dart';
import '../models/category.dart';
import '../models/meal.dart';

class HomeController {
  List<Category> categories = [];
  Meal? randomMeal;
  bool isLoading = true;

  Future<void> loadData() async {
    final cats = await MealDBService.getCategories();
    final random = await MealDBService.getRandomMeal();
    categories = cats;
    randomMeal = random;
    isLoading = false;
  }
}
