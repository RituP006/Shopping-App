import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    
    Widget alertBox(ctx) {
      return AlertDialog(
        title: Text('Are You Sure?'),
        content: Text('You want to delete this product'),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              try {
                Navigator.of(ctx).pop();

                await Provider.of<Products>(ctx, listen: false)
                    .deleteProduct(id);
              } catch (error) {
                // Navigator.of(context1).pop();

                scaffold.showSnackBar(SnackBar(
                  content: Text(error.toString()),
                ));
              }
            },
            child: Text('Yes'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('No'),
          ),
        ],
      );
    }

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                return showDialog<AlertDialog>(
                  context: context,
                  builder: (ctx) => alertBox(ctx),
                );
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}

// NetworkImage is not a widget but an object that fetches image and forward it.

// problem - when we use Scaffold.of(context) inside a async function, everything in that function is wrapped in a future and Scaffold
// doesn't work due to how Flutter works internally.
