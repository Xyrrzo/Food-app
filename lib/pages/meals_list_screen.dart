import 'package:flutter/material.dart';
import '../models/meal_preview.dart';
import '../services/meal_db_service.dart';
import '../widgets/meal_card.dart';

class MealsListScreen extends StatefulWidget {
  final String title;
  final String type;
  final String value;
  final List<MealPreview>? meals;

  const MealsListScreen({
    super.key,
    required this.title,
    required this.type,
    required this.value,
    this.meals,
  });

  @override
  State<MealsListScreen> createState() => _MealsListScreenState();
}

class _MealsListScreenState extends State<MealsListScreen> {
  List<MealPreview> meals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.meals != null) {
      meals = widget.meals!;
      isLoading = false;
    } else {
      _loadMeals();
    }
  }

  Future<void> _loadMeals() async {
    try {
      List<MealPreview> data;
      switch (widget.type) {
        case 'category':
          data = await MealDBService.getMealsByCategory(widget.value);
          break;
        case 'area':
          data = await MealDBService.getMealsByArea(widget.value);
          break;
        case 'search':
          data = await MealDBService.searchMeals(widget.value);
          break;
        default:
          data = [];
      }
      setState(() {
        meals = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32)))
          : meals.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.no_meals, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No meals found'),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) => MealCard(meal: meals[index]),
                ),
    );
  }
}