import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 'p1',
        title: 'RedShirt',
        description: 'A red shirt it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://images.pexels.com/photos/1956070/pexels-photo-1956070.jpeg?cs=srgb&dl=pexels-ingrid-santana-1956070.jpg&fm=jpg'),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'Body fitting jeans',
        price: 85.99,
        imageUrl:
            'https://media.istockphoto.com/photos/woman-jeans-isolated-folded-trendy-stylish-female-blue-jeans-trousers-picture-id1208196754?b=1&k=6&m=1208196754&s=170667a&w=0&h=DMpmAHi0uP1WSCKBvRpu3xeuDXTznIaUHGImgzZWdPM='),
    Product(
        id: 'p3',
        title: 'floral shirt',
        description: 'Aperfect winter match',
        price: 129,
        imageUrl:
            'https://media.istockphoto.com/photos/studio-shot-of-young-handsome-tourist-man-thinking-while-wearing-picture-id665357994?b=1&k=6&m=665357994&s=170667a&w=0&h=U2TYNy3ZuZNET8i4OI_u7lH7FJ_pMn3sJPZrzqfUJD4='),
    Product(
        id: 'p4',
        title: 'skirt',
        description: 'Skirt to match all pair',
        price: 125,
        imageUrl:
            'https://media.istockphoto.com/photos/red-elegant-skirt-with-ribbon-bow-isolated-on-white-picture-id882157056?b=1&k=6&m=882157056&s=170667a&w=0&h=gf6wLGZwv2YHvz5YMyOrK9VISindQm0Y18cPkE5ZDKM='),
    Product(
        id: 'p5',
        title: 'saree',
        description: 'Silk saree with fine hand work',
        price: 229.89,
        imageUrl:
            'https://cdn.pixabay.com/photo/2015/10/26/06/51/designer-saree-1006688__340.jpg'),
    Product(
        id: 'p6',
        title: 'shirt',
        description: 'Free size available',
        price: 209,
        imageUrl:
            'https://cdn.pixabay.com/photo/2014/11/09/19/17/mens-shirt-524022__340.jpg'),
    Product(
        id: 'p7',
        title: 'socks',
        description: 'All colors available',
        price: 19.12,
        imageUrl:
            'https://media.istockphoto.com/photos/man-wearing-sandals-picture-id72736585?b=1&k=6&m=72736585&s=170667a&w=0&h=VbSMJLF3U_GrqWxYL6z-I-LZbAseawnnCt564e1a2LE='),
    Product(
        id: 'p8',
        title: 'prom wear',
        description: 'Out of stock',
        price: 20.3,
        imageUrl:
            'https://media.istockphoto.com/photos/romantic-pink-dress-with-shoesvintage-style-picture-id578573556?b=1&k=6&m=578573556&s=170667a&w=0&h=hhnnCmiGBQcHG9q15UYdHQzyaQy15gm5y1mPYMiMttU='),
  ];

  // var _showOnlyFavorite = false;

  List<Product> get items {
    // if (_showOnlyFavorite) {
    //   return _items.where((prod) => prod.isFavourite).toList();
    // }
    return [..._items]; // check note 1
  }

// see note -2 for why below part is commented
  // void showFav() {
  //   _showOnlyFavorite = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showOnlyFavorite = false;
  //   notifyListeners();
  // }

  List<Product> get favItems {
    return _items.where((prod) => prod.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct(Product product) {
    final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: DateTime.now().toString());
    _items.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
    }

    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}

// Changenotifier class - It's added as Mixin by using with keyword. It's related to inherited widget which allow establishing
// behind the scene communication tunnel with the help of the context object which we get in every widget.

// Mixin - its like extending other class, but main difference is that we merge some properties and methods in existing class and
// you don't return your class into an instance of that inherited class.

// Note-1 : here we return copy of items, since lists are reference types if we return the _items we make it vulnerable to changes
//  from anywhere that access it. To avoid this we send its copy.

// Note-2 : We cannot manage the show fav here as it will affect on every part of app that uses products. Alternative would
// be to use it in widget that needs to show fav.
