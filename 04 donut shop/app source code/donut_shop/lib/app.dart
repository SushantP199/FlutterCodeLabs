import 'package:donut_shop/landing_page/donut_bottom_bar.dart';
import 'package:donut_shop/landing_page/donut_favorites_page.dart';
import 'package:donut_shop/landing_page/donut_main_page.dart';
import 'package:donut_shop/landing_page/donut_shop_details.dart';
import 'package:donut_shop/landing_page/donut_shopping_cart_page.dart';
import 'package:donut_shop/landing_page/landing_page.dart';
import 'package:donut_shop/splash_page.dart';
import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonutShop extends StatelessWidget {
  const DonutShop({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DonutBottomBarSelectionService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutShoppingCartService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutsFavoritesService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        navigatorKey: Utils.mainAppNav,
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        routes: {
          "/": (context) => const SplashPage(),
          // "/": (context) => DonutShopDetails(),
          "/main": (context) => const LandingPage(),
          "/details": (context) => DonutShopDetails(),
        },
      ),
    );
  }
}
