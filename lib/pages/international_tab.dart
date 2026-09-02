import 'package:flutter/material.dart';
import '../services/meal_db_service.dart';
import 'meals_list_screen.dart';

class InternationalTab extends StatefulWidget {
  const InternationalTab({super.key});

  @override
  State<InternationalTab> createState() => _InternationalTabState();
}

class _InternationalTabState extends State<InternationalTab> {
  List<String> areas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAreas();
  }

  Future<void> _loadAreas() async {
    try {
      final data = await MealDBService.getAreas();
      setState(() {
        areas = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  /// Map area name to country flag emoji
  String _getFlag(String area) {
    final flags = {
      'American': '🇺🇸',
      'British': '🇬🇧',
      'Canadian': '🇨🇦',
      'Chinese': '🇨🇳',
      'Croatian': '🇭🇷',
      'Dutch': '🇳🇱',
      'Egyptian': '🇪🇬',
      'Filipino': '🇵🇭',
      'French': '🇫🇷',
      'Greek': '🇬🇷',
      'Indian': '🇮🇳',
      'Irish': '🇮🇪',
      'Italian': '🇮🇹',
      'Jamaican': '🇯🇲',
      'Japanese': '🇯🇵',
      'Kenyan': '🇰🇪',
      'Malaysian': '🇲🇾',
      'Mexican': '🇲🇽',
      'Moroccan': '🇲🇦',
      'Polish': '🇵🇱',
      'Portuguese': '🇵🇹',
      'Russian': '🇷🇺',
      'Spanish': '🇪🇸',
      'Thai': '🇹🇭',
      'Tunisian': '🇹🇳',
      'Turkish': '🇹🇷',
      'Ukrainian': '🇺🇦',
      'Unknown': '🏳️',
      'Vietnamese': '🇻🇳',
    };
    return flags[area] ?? '🍽️';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('International Cuisine'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: areas.length,
              itemBuilder: (context, index) {
                final area = areas[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE8F5E9),
                      child: Text(
                        _getFlag(area),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    title: Text(area, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Explore $area dishes'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF2E7D32)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealsListScreen(
                            title: '$area ${_getFlag(area)}',
                            type: 'area',
                            value: area,
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