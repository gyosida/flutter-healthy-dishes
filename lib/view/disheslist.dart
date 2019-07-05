import 'package:flutter/material.dart';
import 'package:vida_saludable/model/dish.dart';
import 'package:vida_saludable/view/dishdetail.dart';
import 'package:vida_saludable/view/dishlistitem.dart';

class DishesList extends StatelessWidget {
  final List<Dish> _dishes;

  const DishesList(this._dishes);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        children: _buildDishesList(context));
  }

  List<DishListItem> _buildDishesList(BuildContext context) {
    return _dishes
        .map((dish) => DishListItem(
              dish,
              (selectedDish) => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DishDetail(selectedDish)))
                  },
            ))
        .toList();
  }
}
