import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = './editproduct';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _desFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _isInIt = true;
  var _initValues = {
    'title': "",
    "dscription": "",
    'price': "",
    'imageUrl': "",
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_imageUrlUpdate);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInIt) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          "description": _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': "",
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInIt = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_imageUrlUpdate);
    _priceFocusNode.dispose();
    _desFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _imageUrlUpdate() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _form.currentState.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_desFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid nummber';
                    }
                    if (double.parse(value) <= 0) {
                      return "Please enter a nummber grerater than zero";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value),
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _desFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a description";
                    }
                    if (value.length < 10) {
                      return "Should ne atleast 10 characters long ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter a URL";
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'please enter a valid image URL';
                          }

                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: value,
                            isFavourite: _editedProduct.isFavourite,
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}

// FocusNode() - Class in flutter that's use to create focus node,
// which then can be assigned to text fields and focus can be shifted from one text field to another.

// Note : You have to despose focus node when your states get clear, while leaving the screen or object is removed since they can cause memory leaks.abstract

// A Problem!
// TextInputField() - It takes as much width as it gets, if we use this as a child of Row(),row doesn't have boundaries so
// TextInputField tries to take infinite width, therefore wrap it with Expanded() widget.

// Global key
// Its used to get direct access to widgets from inside our code, mostly used with Form Widget.

// double.tryParse() does not throw erroe when it fails but returns null value.

// Note : In TextFormField, we cannot set initial value and controller at the same time, therefore to initialize while using controller
// initialize the controller with initial value as done here for imageUrl.
