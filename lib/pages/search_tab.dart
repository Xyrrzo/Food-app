import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_ninjas_service.dart';
import '../widgets/recipe_card.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _controller = TextEditingController();
  List<Recipe> results = [];
  bool isSearching = false;
  String? errorMessage;

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      isSearching = true;
      errorMessage = null;
      results = [];
    });

    try {
      final recipes = await ApiNinjasService.searchRecipes(query.trim());
      setState(() {
        results = recipes;
        isSearching = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search recipes (e.g., chicken, pasta, adobo...)',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF2E7D32)),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF2E7D32)),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            results = [];
                            errorMessage = null;
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF2E7D32)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                ),
                filled: true,
                fillColor: const Color(0xFFE8F5E9),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: _search,
              onChanged: (value) => setState(() {}),
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: const Color(0xFFFFEBEE),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Color(0xFFC62828)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Color(0xFFC62828)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isSearching)
            const Expanded(child: Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32))))
          else if (results.isNotEmpty)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) => RecipeCard(recipe: results[index]),
              ),
            )
          else if (_controller.text.isNotEmpty && !isSearching && errorMessage == null)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No recipes found', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu,
                        size: 80, color: const Color(0xFF2E7D32).withOpacity(0.3)),
                    const SizedBox(height: 16),
                    Text(
                      'Search for delicious recipes',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: ['chicken', 'pasta', 'pizza', 'curry', 'adobo', 'burger'].map((s) {
                        return ActionChip(
                          backgroundColor: const Color(0xFFE8F5E9),
                          side: const BorderSide(color: Color(0xFF2E7D32)),
                          label: Text(s, style: const TextStyle(color: Color(0xFF2E7D32))),
                          avatar: const Icon(Icons.search, size: 16, color: Color(0xFF2E7D32)),
                          onPressed: () {
                            _controller.text = s;
                            _search(s);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}