import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'recipes_list_screen.dart';

class LocalTab extends StatelessWidget {
  const LocalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local / Filipino Dishes'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: FoodCategories.local.length,
        itemBuilder: (context, index) {
          final dish = FoodCategories.local[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(Icons.restaurant, color: Color(0xFF2E7D32)),
              ),
              title: Text(dish['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Filipino cuisine'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF2E7D32)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipesListScreen(
                      title: dish['name']!,
                      query: dish['query']!,
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