class MealModel {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String instructions;
  final List<String> ingredients;
  final String time;
  final String difficulty;

  MealModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.instructions,
    required this.ingredients,
    this.time = "30 Dəq",
    this.difficulty = "Orta",
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
      id: meal['idMeal'],
      title: meal['strMeal'],
      imageUrl: meal['strMealThumb'],
      category: meal['strCategory'],
      instructions:
          meal['strInstructions'] ?? 'Hazırlanma qaydası qeyd edilməyib.',
      ingredients: ingredientsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'category': category,
      'instructions': instructions,
      'ingredients': ingredients,
      'time': time,
      'difficulty': difficulty,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      category: map['category'],
      instructions: map['instructions'],
      ingredients: List<String>.from(map['ingredients'] ?? []),
      time: map['time'] ?? '30 Dəq',
      difficulty: map['difficulty'] ?? 'Orta',
    );
  }
}
