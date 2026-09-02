import 'package:flutter/material.dart';
import '../models/meal_preview.dart';
import '../services/meal_db_service.dart';
import '../pages/meal_detail_screen.dart';

class MealCard extends StatelessWidget {
  final MealPreview meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
          ),
        );
        try {
          final fullMeal = await MealDBService.getMealById(meal.id);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MealDetailScreen(meal: fullMeal)),
          );
        } catch (e) {
          Navigator.pop(context);
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Hero(
                tag: 'meal-${meal.id}',
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: const Color(0xFFE8F5E9),
                      child: const Center(
                        child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stack) => Container(
                    color: const Color(0xFFE8F5E9),
                    child: const Center(
                      child: Icon(Icons.restaurant, size: 40, color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  meal.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}