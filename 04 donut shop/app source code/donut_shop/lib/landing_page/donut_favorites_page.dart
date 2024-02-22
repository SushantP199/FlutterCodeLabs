import 'package:donut_shop/landing_page/donut_main_page.dart';
import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonutFavoritesPage extends StatelessWidget {
  const DonutFavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<DonutsFavoritesService>(
      builder: (
        context,
        donutsFavoritesService,
        child,
      ) {
        if (donutsFavoritesService.favoritesDonuts.isEmpty) {
          return Center(
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.grey[300],
                    size: 50,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'You haven\'t selected any favorites yet!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          );
        }
        return DonutFavoritePageConsumer(
          donutsFavoritesService: donutsFavoritesService,
        );
      },
    );
  }
}

class DonutFavoritePageConsumer extends StatefulWidget {
  final DonutsFavoritesService donutsFavoritesService;
  const DonutFavoritePageConsumer({
    super.key,
    required this.donutsFavoritesService,
  });

  @override
  State<DonutFavoritePageConsumer> createState() =>
      _DonutFavoritePageConsumerState();
}

class _DonutFavoritePageConsumerState extends State<DonutFavoritePageConsumer> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<DonutModel> insertedItems = [];

  @override
  void initState() {
    super.initState();
    var future = Future(() {});
    for (var i = 0;
        i < widget.donutsFavoritesService.favoritesDonuts.length;
        i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 125), () {
          insertedItems.add(widget.donutsFavoritesService.favoritesDonuts[i]);
          _key.currentState?.insertItem(i);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: AnimatedList(
        key: _key,
        initialItemCount: insertedItems.length,
        itemBuilder: (context, index, animation) {
          DonutModel currentDonut =
              widget.donutsFavoritesService.favoritesDonuts[index];
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: DonutFavoriteTile(
              donut: currentDonut,
              removeFavorite: () {
                widget.donutsFavoritesService.removeFavorite(currentDonut);
                _key.currentState!.removeItem(
                  index,
                  (context, animation) => const SizedBox(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DonutFavoriteTile extends StatelessWidget {
  final DonutModel donut;
  final Function removeFavorite;
  const DonutFavoriteTile({
    super.key,
    required this.donut,
    required this.removeFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          '${donut.imgUrl}',
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${donut.name}',
                style: const TextStyle(
                  color: Utils.mainDark,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 1,
                      bottom: 1,
                      left: 5,
                      right: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Utils.mainDark.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      '\$${donut.price!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Utils.mainDark.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 1,
                      bottom: 1,
                      left: 5,
                      right: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Utils.mainDark.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Utils.mainDark.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      '${donut.type}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            removeFavorite();
          },
          icon: const Icon(
            Icons.favorite,
            color: Utils.mainDark,
          ),
        ),
      ],
    );
  }
}

class DonutsFavoritesService extends ChangeNotifier {
  List<DonutModel> favoritesDonuts = [];

  void addToFavorite(DonutModel donut) {
    favoritesDonuts.add(donut);
    notifyListeners();
  }

  void removeFavorite(DonutModel donut) {
    favoritesDonuts.removeWhere((d) => d.name == donut.name);
    notifyListeners();
  }

  bool donutIsFavorite(DonutModel donut) {
    return favoritesDonuts.any((d) => d.name == donut.name);
  }
}
