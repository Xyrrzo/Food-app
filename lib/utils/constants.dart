class AppConstants {
  static const String appName = 'Food Explorer';
}

class FoodCategories {
  static const List<Map<String, String>> international = [
    {'name': 'Italian', 'query': 'pasta'},
    {'name': 'American', 'query': 'burger'},
    {'name': 'Mexican', 'query': 'taco'},
    {'name': 'Japanese', 'query': 'sushi'},
    {'name': 'Indian', 'query': 'curry'},
    {'name': 'Chinese', 'query': 'noodles'},
    {'name': 'Thai', 'query': 'pad thai'},
    {'name': 'French', 'query': 'croissant'},
    {'name': 'Korean', 'query': 'bibimbap'},
    {'name': 'Mediterranean', 'query': 'hummus'},
  ];

  static const List<Map<String, String>> local = [
    {'name': 'Adobo', 'query': 'adobo'},
    {'name': 'Sinigang', 'query': 'sinigang'},
    {'name': 'Kare-Kare', 'query': 'kare kare'},
    {'name': 'Lechon', 'query': 'lechon'},
    {'name': 'Pancit', 'query': 'pancit'},
    {'name': 'Lumpia', 'query': 'lumpia'},
    {'name': 'Sisig', 'query': 'sisig'},
    {'name': 'Tinola', 'query': 'tinola'},
  ];
}
