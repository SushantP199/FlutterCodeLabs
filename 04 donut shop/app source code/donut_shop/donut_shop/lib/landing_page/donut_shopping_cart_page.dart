import 'package:donut_shop/landing_page/donut_main_page.dart';
import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonutShoppingCartPage extends StatefulWidget {
  const DonutShoppingCartPage({super.key});

  @override
  State<DonutShoppingCartPage> createState() => _DonutShoppingCartPageState();
}

class _DonutShoppingCartPageState extends State<DonutShoppingCartPage>
    with SingleTickerProviderStateMixin {
  AnimationController? titleAnimation;

  @override
  void initState() {
    super.initState();
    titleAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    titleAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: titleAnimation!,
                curve: Curves.easeInOut,
              ),
            ),
            child: Image.network(
              Utils.donutTitleMyDonuts,
              width: 170,
            ),
          ),
          Expanded(
            child: Consumer<DonutShoppingCartService>(
              builder: (
                BuildContext context,
                DonutShoppingCartService donutShoppingCartService,
                Widget? child,
              ) {
                if (donutShoppingCartService.cartDonuts.isEmpty) {
                  return Center(
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.grey[300],
                            size: 50,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'You don\'t have any items on your cart yet!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return DonutShoppingList(
                  donutCart: donutShoppingCartService.cartDonuts,
                  donutShoppingCartService: donutShoppingCartService,
                );
              },
            ),
          ),
          Consumer<DonutShoppingCartService>(
            builder: (
              context,
              cartService,
              child,
            ) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  cartService.cartDonuts.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(color: Utils.mainDark),
                            ),
                            Text(
                              '\$${cartService.getTotal().toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Utils.mainDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      color: cartService.cartDonuts.isEmpty
                          ? Colors.grey[200]
                          : Utils.mainColor.withOpacity(0.2),
                      child: InkWell(
                        splashColor: Utils.mainDark.withOpacity(0.2),
                        highlightColor: Utils.mainDark.withOpacity(0.5),
                        onTap: cartService.cartDonuts.isEmpty
                            ? null
                            : () {
                                cartService.clearCart();
                              },
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_forever,
                                color: cartService.cartDonuts.isEmpty
                                    ? Colors.grey
                                    : Utils.mainDark,
                              ),
                              Text(
                                'Clear Cart',
                                style: TextStyle(
                                  color: cartService.cartDonuts.isEmpty
                                      ? Colors.grey
                                      : Utils.mainDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class DonutShoppingList extends StatefulWidget {
  final List<DonutModel>? donutCart;
  final DonutShoppingCartService? donutShoppingCartService;
  const DonutShoppingList({
    super.key,
    this.donutCart,
    this.donutShoppingCartService,
  });

  @override
  State<DonutShoppingList> createState() => _DonutShoppingListState();
}

class _DonutShoppingListState extends State<DonutShoppingList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<DonutModel> insertedItems = [];

  @override
  void initState() {
    super.initState();

    var future = Future(() {});

    for (var i = 0; i < widget.donutCart!.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 125), () {
          insertedItems.add(widget.donutCart![i]);
          _key.currentState!.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _key,
      initialItemCount: insertedItems.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index, animation) {
        DonutModel currentDonut = widget.donutCart![index];
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
          ),
          child: DonutShoppingListRow(
            donut: currentDonut,
            onDeleteRow: () {
              widget.donutShoppingCartService!.removeFromCart(currentDonut);
              _key.currentState!.removeItem(
                index,
                (context, animation) => const SizedBox(),
              );
            },
          ),
        );
      },
    );
  }
}

class DonutShoppingListRow extends StatelessWidget {
  final DonutModel? donut;
  final Function? onDeleteRow;

  const DonutShoppingListRow({super.key, this.donut, this.onDeleteRow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Image.network(
            '${donut!.imgUrl}',
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${donut!.name}',
                  style: const TextStyle(
                    color: Utils.mainDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(
                    top: 1,
                    bottom: 1,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 2,
                      color: Utils.mainDark.withOpacity(0.7),
                    ),
                  ),
                  child: Text(
                    '\$${donut!.price!.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Utils.mainDark.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              onDeleteRow!();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: Utils.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DonutShoppingCartService extends ChangeNotifier {
  List<DonutModel> cartDonuts = [];

  void addToCart(DonutModel donut) {
    cartDonuts.add(donut);
    notifyListeners();
  }

  void removeFromCart(DonutModel donut) {
    cartDonuts.removeWhere((d) => d.name == donut.name);
    notifyListeners();
  }

  void clearCart() {
    cartDonuts.clear();
    notifyListeners();
  }

  double getTotal() {
    double cartTotal = 0.0;
    for (var element in cartDonuts) {
      cartTotal += element.price!;
    }
    return cartTotal;
  }

  bool isDonutInCart(DonutModel donut) {
    return cartDonuts.any((d) => d.name == donut.name);
  }
}
