class Dish {
  const Dish(
      this.id, this.name, this.description, this.ingredients, this.recipe, this.categoryId);

  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String categoryId;
  final String recipe;

  factory Dish.fromJson(Map<String, dynamic> json) {
    final ingredients = json['ingredients'];
    return Dish(
        json['id'],
        json['name'],
        json['description'],
        ingredients == null? null : List<String>.from(ingredients),
        json['recipe'],
        json['categoryID']);
  }
}
