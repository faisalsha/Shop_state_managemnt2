import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/cart.dart';
import 'package:shop_state/providers/products.dart';
import 'package:shop_state/widgets/badge.dart';
import 'package:shop_state/widgets/product_item.dart';

// import 'package:shop_app/widgets/product_item.dart';
enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
                print(selectedValue);
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_bag),
                ),
                value: cart.itemCount.toString()),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavourites),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final bool showFabs;
  ProductsGrid(this.showFabs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFabs ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i], child: ProductItem()),
      itemCount: products.length,
    );
  }
}

//old approach use value constructor instead
// ChangeNotifierProvider(
//           create: (context) => products[i], child: ProductItem()),

//use value constructor if you are only using listview or gridview bcse of the issue that widgets are recycled by the flutter if we are using listview or gridview
