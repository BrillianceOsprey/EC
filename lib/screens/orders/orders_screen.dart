import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/order.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/services/global_methods.dart';
import 'package:flutter_shop_cpt21/services/stripe_payment.dart';
import 'package:provider/provider.dart';
import '../home_screen.dart';
import 'empty_order.dart';
import 'full_order.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/Order-screen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  GlobalMethods globalMethods = GlobalMethods();

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderProvider.getOrders.isEmpty
              ? const Scaffold(
                  body: EmptyOrder(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text('Order (${orderProvider.getOrders.length})'),
                  ),
                  body: Container(
                    margin: const EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                      itemCount: orderProvider.getOrders.length,
                      itemBuilder: (ctx, i) {
                        return ChangeNotifierProvider.value(
                          value: orderProvider.getOrders[i],
                          child: FullOrder(),
                        );
                      },
                    ),
                  ),
                );
        });
  }
}
