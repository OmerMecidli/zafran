class MealModel {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients;
  final String youtubeUrl;
  final String time;
  final String difficulty;

  MealModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.youtubeUrl,
    this.time = '',
    this.difficulty = '',
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    final meal = json['meals'][0];

    List<String> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = meal['strIngredient$i'];
      final measure = meal['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredientsList.add('${measure ?? ''} $ingredient'.trim());
      }
    }

    return MealModel(
      id: meal['idMeal']?.toString() ?? '',
      title: meal['strMeal']?.toString() ?? '',
      imageUrl: meal['strMealThumb']?.toString() ?? '',
      category: meal['strCategory']?.toString() ?? '',
      area: meal['strArea']?.toString() ?? '',
      instructions:
          meal['strInstructions']?.toString() ?? 'Hazırlanma qaydası qeyd edilməyib.',
      ingredients: ingredientsList,
      youtubeUrl: meal['strYoutube']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'category': category,
      'area': area,
      'instructions': instructions,
      'ingredients': ingredients,
      'youtubeUrl': youtubeUrl,
      'time': time,
      'difficulty': difficulty,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      category: map['category'] ?? '',
      area: map['area'] ?? '',
      instructions: map['instructions'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      youtubeUrl: map['youtubeUrl'] ?? '',
      time: map['time']?.toString() ?? '',
      difficulty: map['difficulty']?.toString() ?? '',
    );
  }
}

