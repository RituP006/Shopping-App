import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
        context); // this is how its listening to provider in main.dart
    final products = showFav ? productsData.favItems : productsData.items;

    return GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 3,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: ProductItem(
                // products[index].id,
                // products[index].title,
                // products[index].imageUrl,
                ),
          );
        });
  }
}

// ChangeNotifierProvider.value() should be used with grid or lists(since widgets in list or grid remains same but the data is changed)
// and builder here can give errors but ChangeNotifierProvider.value() will keep up with that.

// Also ChangeNotifierProvider cleans up the data automatically. since loading new data every time we click on it will take more memory.
