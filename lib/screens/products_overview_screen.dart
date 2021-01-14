import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../providers/products_provider.dart';
import '../providers/product.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My shop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show all'),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: ProductsGrid(_showOnlyFav));
  }
}

// GriedView.Builder()
// gridDelegate : SliverGridDelegateWithFixedCrossAxisCount() is used when we want to explicitly define the number of columns. It will squeeze the items to meet the column number.abstract
//              : SliverGridDelegateWithMaxCrossAxisExtent() is used to define the size of each item and according to it number of columns will be adjusted on different sizes.
// itemBuilder : Defines how each item should look and behave

// PopupMenuButton() : opens up a overlay with list of options

// enums are ways to assign labels to integer so to us its a label and behind the scenes work as a integer.
