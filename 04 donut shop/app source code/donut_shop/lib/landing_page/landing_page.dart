import 'package:donut_shop/landing_page/donut_bottom_bar.dart';
import 'package:donut_shop/landing_page/donut_favorites_page.dart';
import 'package:donut_shop/landing_page/donut_main_page.dart';
import 'package:donut_shop/landing_page/donut_shopping_cart_page.dart';
import 'package:donut_shop/landing_page/donut_side_menu.dart';
import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DonutSideMenu(),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Utils.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.network(
          Utils.donutLogoRedText,
          width: 120,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              key: Utils.mainListNav,
              initialRoute: "/main",
              onGenerateRoute: (RouteSettings routeSettings) {
                Widget page;

                switch (routeSettings.name) {
                  case "/main":
                    page = const DonutMainPage();
                    break;
                  case "/favorites":
                    page = const DonutFavoritesPage();
                    break;
                  case "/shoppingcart":
                    page = const DonutShoppingCartPage();
                    break;
                  default:
                    page = const DonutMainPage();
                    break;
                }

                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => page,
                  transitionDuration: const Duration(seconds: 0),
                );
              },
            ),
          ),
          const DonutBottomBar(),
        ],
      ),
    );
  }
}
