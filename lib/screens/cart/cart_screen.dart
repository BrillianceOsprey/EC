import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/cart.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/services/global_methods.dart';
import 'package:flutter_shop_cpt21/services/stripe_payment.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../home_screen.dart';
import 'empty_cart.dart';
import 'full_cart.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/Cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // StripeService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return cartProvider.cartList.isEmpty
        ? const Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart (${cartProvider.cartList.length})'),
              actions: [
                IconButton(
                  onPressed: () async {
                    await globalMethods.showDialogue(
                      context,
                      () => cartProvider.clearCart(),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: cartProvider.cartList.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.cartList.values.toList()[i],
                    child: FullCart(
                      pId: cartProvider.cartList.keys.toList()[i],
                      // id: cartProvider.cartList.values.toList()[i].cartId,
                      // imageUrl: cartProvider.cartList.values.toList()[i].imageUrl,
                      // price: cartProvider.cartList.values.toList()[i].price,
                      // quantity: cartProvider.cartList.values.toList()[i].quantity,
                      // title: cartProvider.cartList.values.toList()[i].title,
                    ),
                  );
                },
              ),
            ),
            bottomSheet:
                _bottomCheckoutSectiomn(context, cartProvider.totalAmount),
          );
  }
}

Widget _bottomCheckoutSectiomn(BuildContext context, double totalAmount) {
  var _uuid = Uuid();

  final cartProvider = Provider.of<CartProvider>(context);

  // StripeTransactionResponse? response;

  // Future<void> payWithCard({required int amount}) async {
  //   response = await StripeService.payWithNewCard(
  //       amount: amount.toString(), currency: 'USD');

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(response!.message),
  //       duration:
  //           Duration(milliseconds: response!.success == true ? 1200 : 3000),
  //     ),
  //   );
  // }

  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Total: \$ ${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              double amountInCents = totalAmount * 1000;
              int integerAMount = (amountInCents / 10).ceil();
              // await payWithCard(amount: integerAMount);

              // if (response!.success == true) {
              //   User? user = FirebaseAuth.instance.currentUser;
              //   final _uid = user!.uid;
              //   cartProvider.cartList.forEach((key, orderValue) async {
              //     final orderId = _uuid.v4();
              //     try {
              //       await FirebaseFirestore.instance
              //           .collection('orders')
              //           .doc(orderId)
              //           .set({
              //         'orderId': orderId,
              //         'userId': _uid,
              //         'productId': orderValue.productId,
              //         'title': orderValue.title,
              //         'price': orderValue.price,
              //         'imageUrl': orderValue.imageUrl,
              //         'quantity': orderValue.quantity,
              //         'orderDate': Timestamp.now(),
              //       });
              //     } catch (error) {}
              //   });
              // }
            },
            child: Text(
              '   C H E C K O U T   ',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
