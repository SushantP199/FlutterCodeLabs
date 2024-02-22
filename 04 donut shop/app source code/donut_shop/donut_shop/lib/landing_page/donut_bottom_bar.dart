import 'package:donut_shop/landing_page/donut_shopping_cart_page.dart';
import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonutBottomBar extends StatelessWidget {
  const DonutBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Consumer<DonutBottomBarSelectionService>(
        builder: (context, donutBottomBarSelectionService, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  donutBottomBarSelectionService.setTabSelection('main');
                },
                icon: Icon(
                  Icons.trip_origin,
                  color: donutBottomBarSelectionService.tabSelection! == 'main'
                      ? Utils.mainDark
                      : Utils.mainColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  donutBottomBarSelectionService.setTabSelection('favorites');
                },
                icon: Icon(
                  Icons.favorite,
                  color: donutBottomBarSelectionService.tabSelection! ==
                          'favorites'
                      ? Utils.mainDark
                      : Utils.mainColor,
                ),
              ),
              Consumer<DonutShoppingCartService>(
                builder: (context, cartService, child) {
                  int cartItems = cartService.cartDonuts.length;
                  return InkWell(
                    borderRadius: BorderRadius.circular(50),
                    splashColor: Colors.white,
                    onTap: () {
                      donutBottomBarSelectionService
                          .setTabSelection('shoppingcart');
                    },
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 70),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cartItems > 0
                            ? (donutBottomBarSelectionService.tabSelection! ==
                                    "shoppingcart"
                                ? Utils.mainDark
                                : Utils.mainColor)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          cartItems > 0
                              ? Text(
                                  '$cartItems',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                )
                              : const SizedBox(height: 17),
                          const SizedBox(height: 10),
                          Icon(
                            Icons.shopping_cart,
                            color: cartItems > 0
                                ? Colors.white
                                : donutBottomBarSelectionService
                                            .tabSelection! ==
                                        'shoppingcart'
                                    ? Utils.mainDark
                                    : Utils.mainColor,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class DonutBottomBarSelectionService extends ChangeNotifier {
  String? tabSelection = 'main';

  void setTabSelection(String selection) {
    Utils.mainListNav.currentState!.pushReplacementNamed('/$selection');
    tabSelection = selection;
    notifyListeners();
  }
}
