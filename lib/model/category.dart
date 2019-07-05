class Category {
  final String id;
  final String name;

  const Category(this.id, this.name);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['id'], json['name']);
  }
}
