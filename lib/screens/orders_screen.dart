import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_state/providers/orders.dart' show Orders;
import 'package:shop_state/widgets/app_drawer.dart';
import '../widgets/order_item.dart' as ord;

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, index) {
            return ord.OrderItem(order: ordersData.orders[index]);
          }),
    );
  }
}
