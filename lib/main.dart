import 'package:flutter/material.dart';
import 'package:vida_saludable/data/io/dishessource.dart';
import 'package:vida_saludable/data/io/categorysource.dart';
import 'package:vida_saludable/model/category.dart';
import 'package:vida_saludable/model/dish.dart';
import 'package:vida_saludable/view/disheslist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vida Saludable',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HealthyDishesHome(),
    );
  }
}

class HealthyDishesHome extends StatelessWidget {
  final _categories = <Category>[
    Category("1", "Deportista"),
    Category("2", "Normal")
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Vida Saludable"),
            centerTitle: true,
            bottom: TabBar(
              tabs: _buildTabs(),
              labelStyle: TextStyle(
                fontSize: 18,
              ),
            )),
        body: FutureBuilder(
            future: Future.wait([categories(), healthyDishes()])
                .then((response) => HealthyHomeDTO(response[0], response[1])),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? TabBarView(children: _buildTabBarViews(snapshot.data))
                  : Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return _categories.map((category) => Tab(text: category.name)).toList();
  }

  List<Widget> _buildTabBarViews(HealthyHomeDTO healthyHomeDTO) {
    return healthyHomeDTO.categories
        .map((category) => DishesList(healthyHomeDTO.dishes
            .where((dish) => dish.categoryId == category.id)
            .toList()))
        .toList();
  }
}

class HealthyHomeDTO {
  final List<Category> categories;
  final List<Dish> dishes;

  const HealthyHomeDTO(this.categories, this.dishes);
}
