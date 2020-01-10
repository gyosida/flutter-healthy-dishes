import 'dart:async' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vida_saludable/model/dish.dart';
import 'package:vida_saludable/view/image/dishimage.dart';

class DishDetail extends StatelessWidget {
  final Dish _dish;

  const DishDetail(this._dish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_dish.name)),
        body: ListView(
            children: <Widget>[
                  Image.asset(buildDishImage(_dish),
                      height: 250, fit: BoxFit.fill),
                  FavoriteButton()
                ] +
                _buildIngredientsViews() +
                _buildRecipeView()));
  }

  List<Widget> _buildIngredientsViews() {
    if (_dish.ingredients == null) {
      return [];
    }
    return [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text("Ingredientes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))
        ] +
        _dish.ingredients
            .map((ingredient) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text("- $ingredient", style: TextStyle(fontSize: 14))))
            .toList();
  }

  List<Widget> _buildRecipeView() {
    return <Widget>[
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text("Receta",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600))),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(_dish.recipe, style: TextStyle(fontSize: 14)))
              ]))
    ];
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  State createState() {
    return _FavoriteState();
  }
}

class _FavoriteState extends State<FavoriteButton> {
  static const platform = const MethodChannel("lib.view/favorite");

  // todo pass dish

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          _updateFavorite();
        },
        textColor: Colors.deepOrange,
        child: Text(
            _isFavorite ? "Eliminar de Favoritos" : "Agregar a Favoritos"));
  }

  Future<void> _updateFavorite() async {
    final bool isFavorite = await platform.invokeMethod("updateFavorite", <String, dynamic>{
             'isFavorite': _isFavorite,
           });
    setState(() {
      _isFavorite = isFavorite;
    });
  }
}
