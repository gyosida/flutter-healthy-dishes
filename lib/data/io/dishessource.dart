import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:vida_saludable/data/io/file.dart';
import 'package:vida_saludable/model/dish.dart';

Future<List<Dish>> healthyDishes() {
  return loadAsset("dishesdb.json")
      .then((dishesJson) => compute(_parseDishes, dishesJson));
}

List<Dish> _parseDishes(String dishesJson) {
  Map<String, dynamic> parsed = jsonDecode(dishesJson).cast<String, dynamic>();
  return _DishesDTO.fromJson(parsed).dishes;
}

class _DishesDTO {
  final List<Dish> dishes;

  const _DishesDTO(this.dishes);

  factory _DishesDTO.fromJson(Map<String, dynamic> json) {
    Iterable dishesJson = json['dishes'] as Iterable;
    return _DishesDTO(dishesJson.map((dishJson) => Dish.fromJson(dishJson)).toList());
  }
}
