import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './screens/splash_screen.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(),
          update: (ctx, auth, previousProducts) =>
              previousProducts..update(auth.token, auth.userId),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(),
          update: (ctx, authData, previousOrder) =>
              previousOrder..update(authData.token, authData.userId),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'OpenSans',
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              })),
          home: authData.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (
                    ctx,
                    authResultSnapshot,
                  ) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            // '/': (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}

// ********** setting a provider *********

// we need to attach the provider to higest possible point of the widgets that are listening.
// eg. here ProductOverviewScreen() and ProductDetailScreen() are listening and therefore we need to provide the class in a widget
//  that is above them i.e MyApp widget.

// Step - 1 : Import the provider
// import provider.dart from provider package.
// import provider class

// Step -2 : Register a provider
// wrap MaterialApp into a new provider widget, here it is ChangeNotifierProvider().
// provide a builder method to create argument which returns the new instance of product class.
// update - if there's no need of context, then ChangeNotifierProvider().value can be used.

// Now all child widgets that are interested to listen will listen to this new instance of product.
// only widgets that listen to provider will be rebuilt when data changes and not the entire app.

// now for how to listen see ProductOverviewScreen

// *************** set multiple providers **********
// use Multiprovider() and pass list of providers as an argument. when multiple providers are required.
