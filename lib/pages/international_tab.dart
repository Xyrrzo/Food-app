import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'recipes_list_screen.dart';

class InternationalTab extends StatelessWidget {
  const InternationalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('International Cuisine'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: FoodCategories.international.length,
        itemBuilder: (context, index) {
          final cuisine = FoodCategories.international[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFE8F5E9),
                child: Text(
                  cuisine['name']![0],
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(cuisine['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('Explore ${cuisine['name']} recipes'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF2E7D32)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipesListScreen(
                      title: cuisine['name']!,
                      query: cuisine['query']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}