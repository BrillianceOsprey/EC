import 'package:backdrop/backdrop.dart';
import 'package:badges/badges.dart' as badges;
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/product.dart';
import 'package:flutter_shop_cpt21/models%20&%20providers/wishlist.dart';
import 'package:flutter_shop_cpt21/screens/feeds_screen.dart';
import 'package:flutter_shop_cpt21/screens/inner_screens/brands_nav_rail.dart';
import 'package:flutter_shop_cpt21/screens/wishlist/wishlist_screen.dart';
import 'package:flutter_shop_cpt21/widgets/back_layer.dart';
import 'package:flutter_shop_cpt21/widgets/category.dart';
import 'package:flutter_shop_cpt21/widgets/popular_propducts.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/Home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _carouselImages = [
    Image.asset('assets/images/carousel1.png'),
    Image.asset('assets/images/carousel2.jpeg'),
    Image.asset('assets/images/carousel3.jpeg'),
    Image.asset('assets/images/carousel4.png'),
  ];

  final List _swiperImages = [
    'assets/images/addidas.jpeg',
    'assets/images/apple.jpeg',
    'assets/images/Dell.jpeg',
    'assets/images/h&m.jpeg',
    'assets/images/Huawei.jpeg',
    'assets/images/nike.jpeg',
    'assets/images/samsung.jpeg',
  ];
  ProductProvider productProvider = ProductProvider();
  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<ProductProvider>(context);
    final popularProduct = productProvider.popularProducts;
    print('Product list ${popularProduct.length}');
    productProvider.fetchProducts();

    return Scaffold(
      body: BackdropScaffold(
        headerHeight: MediaQuery.of(context).size.height * 0.4,
        backLayerBackgroundColor: Colors.grey.shade900,
        appBar: BackdropAppBar(
          title: const Text('Flutter Shop'),
          leading: const BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          actions: [
            Consumer<WishlistProvider>(builder: (context, wp, _) {
              return badges.Badge(
                // toAnimate: true,
                // animationType: BadgeAnimationType.slide,
                // position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  wp.wishlistList.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistScreen.routeName);
                  },
                  icon: const Icon(Icons.favorite),
                ),
              );
            }),
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                    'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
        backLayer: const BackLayer(),
        frontLayer: ListView(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Carousel(
                images: _carouselImages,
                indicatorBgPadding: 7,
                dotSize: 5,
                boxFit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (ctx, i) {
                  return Row(
                    children: [
                      Category(
                        i: i,
                      ),
                      const SizedBox(width: 10),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Brands',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          BrandsNavRailScreen.routeName,
                          arguments: 7,
                        );
                      },
                      child: const Text('view all')),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Swiper(
                onTap: (index) {
                  Navigator.of(context).pushNamed(
                    BrandsNavRailScreen.routeName,
                    arguments: index,
                  );
                },
                autoplay: true,
                viewportFraction: 0.8,
                scale: 0.9,
                itemCount: _swiperImages.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      _swiperImages[i],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          FeedsScreen.routeName,
                          arguments: 'popular',
                        );
                      },
                      child: const Text('view all')),
                ],
              ),
            ),
            SizedBox(
              // color: Colors.amber,
              height: 300,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularProduct.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: popularProduct[i],
                    child: const PopularProducts(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
