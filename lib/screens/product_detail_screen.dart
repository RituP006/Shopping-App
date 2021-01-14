import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = './ProductDetailScreen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${loadedProduct.title} \$${loadedProduct.price}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// when any widget doesn't needs to be rebuilt with every update in provider, we can set listen to false.
