import 'package:flutter/material.dart';
import 'package:paradise/main.dart';

final List<Attraction> attractionsList = [
  Attraction(
    imgPath:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/275162028.jpg?k=38b638c8ec9ec86624f9a598482e95fa634d49aa3f99da1838cf5adde1a14521&o=&hp=1',
    name: 'Grand Bavaro Princess',
    desc: 'All-Inclusive Resort',
    location: 'Punta Cana, DR',
    rating: 3,
    price: 80.0,
  ),
  Attraction(
    imgPath:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/232161008.jpg?k=27808fe44ab95f6468e5433639bf117032c8271cebf5988bdcaa0a202b9a6d79&o=&hp=1',
    name: 'Hyatt Ziva Cap Cana',
    desc: 'All-Inclusive Resort',
    price: 90.0,
    rating: 4,
    location: 'Punta Cana, DR',
  ),
  Attraction(
    imgPath:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/256931299.jpg?k=57b5fb9732cd89f308def5386e221c46e52f48579345325714a310addf819274&o=&hp=1',
    name: 'Impressive Punta Cana',
    desc: 'All-Inclusive Resort',
    price: 100.0,
    rating: 5,
    location: 'Punta Cana, DR',
  ),
  Attraction(
    imgPath:
        'https://cf.bstatic.com/xdata/images/hotel/max1024x768/283750757.jpg?k=4f3437bf1e1b077463c9900e4dd015633db1d96da38f034f4b70a4ba3ef76d82&o=&hp=1',
    name: 'Villas Mar Azul Dreams',
    desc: 'All-Inclusive Resort',
    price: 100.0,
    rating: 4,
    location: 'Tallaboa, PR',
  ),
];

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainThemeColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Icon(Icons.pool, color: Colors.white),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: attractionsList.length,
                itemBuilder: (context, index) {
                  Attraction attr = attractionsList[index];
                  return AttractionCard(
                    attraction: attr,
                  );
                },
              ),
            ),
            const BottomBarWidget(),
          ],
        ),
      ),
    );
  }
}

class AttractionCard extends StatelessWidget {
  Attraction? attraction;

  AttractionCard({
    this.attraction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.1),
            offset: Offset.zero,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: SizedBox(
          height: 300,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          attraction!.imgPath!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              attraction!.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.pin_drop,
                                  color: Colors.grey.withOpacity(0.7),
                                  size: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  attraction!.location!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            RatingWidget(
                              rating: attraction!.rating!,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${attraction!.price!.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Per night",
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: mainThemeColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: mainThemeColor,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_outlined,
                    color: Colors.white,
                    size: 15,
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

class Attraction {
  String? imgPath;
  String? name;
  String? desc;
  double? price;
  String? location;
  int? rating;

  Attraction({
    this.imgPath,
    this.name,
    this.desc,
    this.price,
    this.location,
    this.rating,
  });
}

class RatingWidget extends StatelessWidget {
  final int? rating;

  const RatingWidget({
    this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            5,
            (index) {
              return Icon(
                index < rating! ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              );
            },
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "${rating!}/5 Reviews",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

final List<BottomBarItem> barItemsList = [
  BottomBarItem(label: 'Home', isSelected: true, icon: Icons.home),
  BottomBarItem(label: 'Account', isSelected: false, icon: Icons.person),
  BottomBarItem(
      label: 'Bookings', isSelected: false, icon: Icons.pending_actions),
  BottomBarItem(label: 'Payments', isSelected: false, icon: Icons.payments),
  BottomBarItem(label: 'More', isSelected: false, icon: Icons.more_horiz),
];

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  List<BottomBarItem> barItems = barItemsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        right: 20,
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(barItems.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                for (BottomBarItem element in barItems) {
                  element.isSelected = barItems[index] == element;
                }
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  barItems[index].icon,
                  color: barItems[index].isSelected!
                      ? mainThemeColor
                      : Colors.grey,
                ),
                Text(
                  barItems[index].label!,
                  style: TextStyle(
                    color: barItems[index].isSelected!
                        ? mainThemeColor
                        : Colors.grey,
                    fontSize: 11,
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class BottomBarItem {
  IconData? icon;
  String? label;
  bool? isSelected;

  BottomBarItem({this.icon, this.label, this.isSelected});
}
