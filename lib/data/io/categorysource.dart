import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vida_saludable/data/io/file.dart';
import 'package:vida_saludable/model/category.dart' as model;

Future<List<model.Category>> categories() {
  return loadAsset("categories.json")
      .then((categoriesJson) => compute(_parseCategories, categoriesJson));
}

List<model.Category> _parseCategories(String categoriesJson) {
  Map<String, dynamic> parsed = jsonDecode(categoriesJson).cast<String, dynamic>();
  return CategoriesDTO.fromJson(parsed).categories;
}

class CategoriesDTO {
  final List<model.Category> categories;

  const CategoriesDTO(this.categories);

  factory CategoriesDTO.fromJson(Map<String, dynamic> json) {
    Iterable categories = json['categories'] as Iterable;
    return CategoriesDTO(categories.map((categoryJson) => model.Category.fromJson(categoryJson)).toList());
  }
}
