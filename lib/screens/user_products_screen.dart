import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/UserProductScreen';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          const IconButton(icon: Icon(Icons.add), onPressed: null),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, index) => Column(
            children: [
              UserProductItem(
                productsData.items[index].title,
                productsData.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
