import 'package:flutter/cupertino.dart';
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

    Widget customerReview(String name, String img, int num) {
      return ListTile(
        leading: Container(
          height: 50.0,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('$img'),
            ),
          ),
        ),
        title: Text('$name'),
        trailing: num < 3 ? Icon(Icons.thumb_down) : Icon(Icons.thumb_up),
        subtitle: Row(
          children: [
            Icon(
              Icons.star_rate,
              size: 15,
            ),
            SizedBox(
              width: 2,
            ),
            if (num > 1)
              Icon(
                Icons.star_rate,
                size: 15,
              ),
            SizedBox(
              width: 2,
            ),
            if (num > 2)
              Icon(
                Icons.star_rate,
                size: 15,
              ),
            SizedBox(
              width: 2,
            ),
            if (num > 3)
              Icon(
                Icons.star_half_sharp,
                size: 15,
              ),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            actionsIconTheme: IconThemeData(color: Colors.black),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 24, right: 0),
                  child: Text(
                    loadedProduct.title,
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Row(
                    children: [
                      Text(
                        '\u{20B9}${loadedProduct.price}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '/ 0',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Container(
                    width: 50,
                    margin: EdgeInsets.only(right: 250),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'In Stock',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      width: 80,
                      child: loadedProduct.isFavorite
                          ? Icon(
                              Icons.favorite_rounded,
                              color: Colors.red.shade600,
                              size: 30,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.red.shade600,
                              size: 30,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Text(
                    '${loadedProduct.description}. This product is highly demanded, made from fabric thats of best quality.',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Row(
                    children: [
                      Text(
                        'See More Details',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Theme.of(context).accentColor,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade800,
                            shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                            // color: Colors.blue.shade500,
                            border: Border.all(color: Colors.blueGrey.shade800),
                            shape: BoxShape.circle),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent.shade100,
                              shape: BoxShape.circle),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
                  child: SizedBox(
                    child: Text(
                      'Customer Reviews',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(
                    children: [
                      customerReview('Sarah joe',
                          './assets/images/customer/customer-1.jpg', 4),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                      customerReview('Anjali Patel',
                          './assets/images/customer/customer-2.jpg', 3),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                      customerReview('Shweta Tiwari',
                          './assets/images/customer/customer-3.jpg', 2),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                      customerReview('Heena Khan',
                          './assets/images/customer/customer-4.jpg', 1),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                      customerReview('Pooja Singh',
                          './assets/images/customer/customer-2.jpg', 3),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                      customerReview('Pallavi Sharma',
                          './assets/images/customer/customer-3.jpg', 1),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                      customerReview('Laiba Ansari',
                          './assets/images/customer/customer-4.jpg', 4),
                      Divider(
                        color: Colors.grey.shade600,
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// when any widget doesn't needs to be rebuilt with every update in provider, we can set listen to false.
