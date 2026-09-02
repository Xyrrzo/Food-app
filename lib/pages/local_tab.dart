import 'package:flutter/material.dart';
import '../services/meal_db_service.dart';
import 'meals_list_screen.dart';

class LocalTab extends StatefulWidget {
  const LocalTab({super.key});

  @override
  State<LocalTab> createState() => _LocalTabState();
}

class _LocalTabState extends State<LocalTab> {
  final List<Map<String, dynamic>> popularDishes = [
    {'name': 'Adobo', 'country': 'Philippines', 'query': 'Adobo'},
    {'name': 'Sinigang', 'country': 'Philippines', 'query': 'Sinigang'},
    {'name': 'Kare-Kare', 'country': 'Philippines', 'query': 'Kare-Kare'},
    {'name': 'Lechon', 'country': 'Philippines', 'query': 'Lechon'},
    {'name': 'Pancit', 'country': 'Philippines', 'query': 'Pancit'},
    {'name': 'Lumpia', 'country': 'Philippines', 'query': 'Lumpia'},
    {'name': 'Sushi', 'country': 'Japan', 'query': 'Sushi'},
    {'name': 'Ramen', 'country': 'Japan', 'query': 'Ramen'},
    {'name': 'Pad Thai', 'country': 'Thailand', 'query': 'Pad Thai'},
    {'name': 'Pho', 'country': 'Vietnam', 'query': 'Pho'},
    {'name': 'Kimchi', 'country': 'Korea', 'query': 'Kimchi'},
    {'name': 'Dim Sum', 'country': 'China', 'query': 'Dim Sum'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Local Dishes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: popularDishes.length,
        itemBuilder: (context, index) {
          final dish = popularDishes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: const Icon(Icons.restaurant),
              ),
              title: Text(
                dish['name']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(dish['country']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _searchDish(dish['query']!),
            ),
          );
        },
      ),
    );
  }

  void _searchDish(String query) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final meals = await MealDBService.searchMeals(query);
      Navigator.pop(context);

      if (meals.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealsListScreen(
              title: query,
              type: 'search',
              value: query,
              meals: meals,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No results found for "$query"')),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading results')),
      );
    }
  }
}
