import 'package:flutter/material.dart';
import 'package:flutter_shop_cpt21/screens/bottom_nav_screen.dart';
import 'package:flutter_shop_cpt21/screens/inner_screens/upload_product_screen.dart';
import 'package:flutter_shop_cpt21/screens/landing_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomNavScreen(),
        UploadProductScreen(),
      ],
    );
  }
}
