import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/cart.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/wishlist.dart';
import 'package:flutter_shop_cpt21/screens/wishlist/wishlist_screen.dart';
import 'package:flutter_shop_cpt21/widgets/feeds_product.dart';
import 'package:provider/provider.dart';
import 'cart/cart_screen.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = '/Feeds-screen';

  FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  Future<void> _getProductsOnrefresh() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList = productProvider.products();
    print('Product list $productsList');

    final popular = ModalRoute.of(context)!.settings.arguments.toString();

    if (popular == 'popular') {
      productsList = productProvider.popularProducts;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds Screen'),
        actions: [
          Consumer<WishlistProvider>(builder: (context, wp, _) {
            return badges.Badge(
              // toAnimate: true,
              // animationType: BadgeAnimationType.slide,
              // position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(wp.wishlistList.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
                },
                icon: const Icon(Icons.favorite),
              ),
            );
          }),
          Consumer<CartProvider>(builder: (context, cp, _) {
            return badges.Badge(
              // toAnimate: true,
              // animationType: BadgeAnimationType.slide,
              // position: BadgePosition.topEnd(top: 5, end: 7),
              badgeContent: Text(cp.cartList.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            );
          }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getProductsOnrefresh,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: productsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) {
              return ChangeNotifierProvider.value(
                value: productsList[i],
                child: FeedsProduct(),
              );
            },
          ),
        ),
      ),
    );
  }
}
