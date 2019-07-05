import 'package:flutter/material.dart';
import 'package:vida_saludable/model/dish.dart';
import 'package:vida_saludable/view/image/dishimage.dart';

typedef void DishClickedCallback(Dish dish);

class DishListItem extends StatelessWidget {
  const DishListItem(this._dish, this.dishClickedCallback);

  final DishClickedCallback dishClickedCallback;
  final Dish _dish;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dishClickedCallback(_dish);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(buildDishImage(_dish),
                height: 150, fit: BoxFit.fitWidth),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  _dish.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18),
                )),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Text(
                _dish.description,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 14, color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
