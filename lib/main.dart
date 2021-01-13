import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/cart.dart';
import 'package:shop_state/providers/orders.dart';
import 'package:shop_state/providers/products.dart';
import 'package:shop_state/screens/cart_screen.dart';
import 'package:shop_state/screens/product_detail_screen.dart';
import 'package:shop_state/screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  return ChangeNotifierProvider<Products>.value(
    //   value: Products(),
    //another approach is use value constructor
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen()
        },
      ),
    );
  }
}
