// defines how each product should look in product overview screen.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return Card(
      elevation: 0,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Hero(
              tag: product.id,
              child: Container(
                width: 140,
                height: 120,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    placeholder:
                        AssetImage('assets/images/product-placeholder.png'),
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: SizedBox(
              width: 145,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            '\u{20B9}${product.price}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Consumer<Product>(
                        builder: (context, product, _) => IconButton(
                          color: Theme.of(context).accentColor,
                          iconSize: 23,
                          alignment: Alignment.topRight,
                          icon: Icon(
                            product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            product
                                .toggleFav(
                              authData.token,
                              authData.userId,
                            )
                                .catchError((error) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(error.toString()),
                              ));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    color: Colors.amberAccent,
                    // height: 25,
                    child: Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      cart.addItemToCart(
                          product.id, product.title, product.price);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added item to cart!'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            },
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// improvisation for performance :
// when we use provider but we want to listen to changes only in apart of widget and thus don't want entire widget to rebuilt -
// we can use Consumer() which always listen to update and set the listen to false for the rest.
// howeever child argument of Consumer takes a widget that never changes, which you can use by referncing as child.

// Scaffold.of(context) - it builds connection to the nearest scaffold widget(widget that controls the page we're seeing) and allows
// to modify the UI in different ways.

// SnackBar() - Material design object thats shoen at the bottom of the screen, its kinda info pop up.
