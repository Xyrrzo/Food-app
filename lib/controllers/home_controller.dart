import '../services/foodish_service.dart';
import '../models/food_image.dart';

class HomeController {
  List<FoodImage> randomImages = [];
  bool isLoading = true;

  Future<void> loadRandomImages() async {
    randomImages = await FoodishService.getMultipleImages(5);
    isLoading = false;
  }
}
