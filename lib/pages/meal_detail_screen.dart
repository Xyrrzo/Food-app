import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
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
                      child: Icon(Icons.restaurant, size: 80, color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (meal.category != null)
                        _buildInfoChip(context, meal.category!, Icons.category, const Color(0xFFE8F5E9)),
                      if (meal.area != null)
                        _buildInfoChip(context, meal.area!, Icons.location_on, const Color(0xFFE8F5E9)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E7D32),
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    meal.ingredients.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${meal.measures[index]} ${meal.ingredients[index]}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E7D32),
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    meal.instructions ?? 'No instructions available.',
                    style: const TextStyle(fontSize: 15, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, IconData icon, Color bgColor) {
    return Chip(
      avatar: Icon(icon, size: 18, color: const Color(0xFF2E7D32)),
      label: Text(label),
      backgroundColor: bgColor,
    );
  }
}