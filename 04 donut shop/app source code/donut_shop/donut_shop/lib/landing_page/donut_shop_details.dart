import 'package:donut_shop/landing_page/donut_favorites_page.dart';
import 'package:donut_shop/landing_page/donut_main_page.dart';
import 'package:donut_shop/landing_page/donut_shopping_cart_page.dart';
import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonutShopDetails extends StatefulWidget {
  DonutModel? selectedDonut;

  DonutShopDetails({
    super.key,
    this.selectedDonut,
  });

  @override
  State<DonutShopDetails> createState() => _DonutShopDetailsState();
}

class _DonutShopDetailsState extends State<DonutShopDetails>
    with SingleTickerProviderStateMixin {
  DonutModel? selectedDonut;
  AnimationController? animationController;
  Animation<double>? rotationAnimation;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DonutService donutService = Provider.of<DonutService>(
      context,
      listen: false,
    );

    selectedDonut = donutService.getSelectedDonut();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Utils.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          width: 120,
          child: Image.network(Utils.donutLogoRedText),
        ),
        centerTitle: true,
        actions: const [DonutShoppingCartBadge()],
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.525,
                child: Stack(
                  children: [
                    Positioned(
                      top: -74,
                      right: -120,
                      width: MediaQuery.of(context).size.width * 1.25,
                      child: Hero(
                        tag: selectedDonut!.name!,
                        child: RotationTransition(
                          turns: rotationAnimation!,
                          child: Image.network(
                            selectedDonut!.imgUrl!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              selectedDonut!.name!,
                              style: const TextStyle(
                                color: Utils.mainDark,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          Consumer<DonutsFavoritesService>(
                            builder: (
                              context,
                              donutsFavoritesService,
                              child,
                            ) {
                              if (donutsFavoritesService.donutIsFavorite(
                                selectedDonut!,
                              )) isFavorite = true;

                              return IconButton(
                                onPressed: () {
                                  isFavorite = !isFavorite;

                                  if (isFavorite) {
                                    donutsFavoritesService.addToFavorite(
                                      selectedDonut!,
                                    );
                                  } else {
                                    donutsFavoritesService.removeFavorite(
                                      selectedDonut!,
                                    );
                                  }
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                ),
                                color: Utils.mainDark,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Utils.mainDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "\$${selectedDonut!.price!.toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(selectedDonut!.description!),
                      Consumer<DonutShoppingCartService>(
                        builder: (context, cartService, child) {
                          if (cartService.isDonutInCart(selectedDonut!)) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_rounded,
                                    color: Utils.mainDark,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Added to Cart',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Utils.mainDark,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              cartService.addToCart(selectedDonut!);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Utils.mainDark.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Utils.mainDark,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                      color: Utils.mainDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonutShoppingCartBadge extends StatelessWidget {
  const DonutShoppingCartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DonutShoppingCartService>(
      builder: (
        BuildContext context,
        DonutShoppingCartService donutShoppingCartService,
        Widget? child,
      ) {
        if (donutShoppingCartService.cartDonuts.isEmpty) {
          return const SizedBox();
        }

        return Transform.scale(
          scale: 0.7,
          child: Container(
            // margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: Utils.mainColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Text(
                  donutShoppingCartService.cartDonuts.length.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
