import 'package:flutter/material.dart';

/* Models */

class MountModel {
  String path;
  String name;
  String location;
  String description;

  MountModel(
      {required this.path,
      required this.name,
      this.location = '',
      this.description = ''});
}

class CategoryModel {
  String category;
  IconData? icon;

  CategoryModel({
    this.category = '',
    this.icon
  });
}

class AppBottomBarItem {
  IconData? icon;
  bool isSelected;
  String label;

  AppBottomBarItem({
    this.icon,
    this.label = '',
    this.isSelected = false
  });
}

/* Globals */
const Color mainColor = Color(0xFFFF5656);

final List<MountModel> mountItems = [
  MountModel(
      path:
          'https://i.insider.com/5a258ab23339b025218b45c0?width=1000&format=jpeg&auto=webp',
      name: 'Mount Semeru',
      location: 'East Java',
      description:
          'Semeru, or Mount Semeru, is an active volcano in East Java, Indonesia. It is located in the subduction zone, where the Indo-Australia plate subducts under the Eurasia plate. It is the highest mountain on the island of Java.'),
  MountModel(
      path:
          'https://media-cdn.tripadvisor.com/media/photo-s/04/a5/6f/ce/dsc-5622jpg.jpg',
      name: 'Mount Merbaru',
      location: 'Central Java',
      description:
          'Mount Merbabu is a dormant stratovolcano in Central Java province on the Indonesian island of Java. The name Merbabu could be loosely translated as Mountain of Ash from the Javanese combined words; Meru means mountain and awu or abu means ash.'),
  MountModel(
      path: 'https://assets.traveltriangle.com/blog/wp-content/uploads/2018/09/swiss-alps.jpg',
      name: 'Mauan Loa',
      location: 'Hawaii',
      description:
          'Mauna Loa is one of five volcanoes that form the Island of Hawaii in the U.S. state of Hawai in the Pacific Ocean. The largest subaerial volcano in both mass and volume, Mauna Loa has historically been considered the largest volcano on Earth, dwarfed only by Tamu Massif.'),
  MountModel(
      path:
          'https://cdn.images.express.co.uk/img/dynamic/78/590x/mount-vesuvius-1100807.jpg',
      name: 'Mount Vesuvius',
      location: 'Italy',
      description:
          'Mount Vesuvius is a somma-stratovolcano located on the Gulf of Naples in Campania, Italy, about 9 km east of Naples and a short distance from the shore. It is one of several volcanoes which form the Campanian volcanic arc.'),
  MountModel(
      path:
          'https://upload.wikimedia.org/wikipedia/commons/0/04/PopoAmeca2zoom.jpg',
      name: 'Mount Popcatepetl',
      location: 'Mexico',
      description:
          'Popocatépetl is an active stratovolcano located in the states of Puebla, Morelos, and Mexico in central Mexico. It lies in the eastern half of the Trans-Mexican volcanic belt. At 5,426 m it is the second highest peak in Mexico, after Citlaltépetl at 5,636 m.'),
];

final List<CategoryModel> categories = [
  CategoryModel(category: 'Mountain', icon: Icons.terrain),
  CategoryModel(category: 'Forest', icon: Icons.park),
  CategoryModel(category: 'Beach', icon: Icons.beach_access),
  CategoryModel(category: 'Hiking', icon: Icons.directions_walk),
];

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DetailsPage(), //SplashPage(),
  ));
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MountsApp()));
    });

    return Container(
      color: mainColor,
      child: Stack(
        children: const [
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.terrain,
              color: Colors.white,
              size: 90,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class MountsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: mainColor),
        centerTitle: true,
        title: const Icon(
          Icons.terrain,
          color: mainColor,
          size: 40,
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: mainColor,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(30.0),
          child: const Icon(
            Icons.terrain,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(),
          AppSearch(),
          Expanded(child: AppMountListView()),
          AppCategoryList(),
          AppBottomBar()
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {

  @override 
  Widget build (BuildContext context){

    var selectedItem = mountItems[0];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children:  [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(selectedItem.path),
                        fit : BoxFit.cover
                      )
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter
                        )
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30, left: 30, right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedItem.name,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          selectedItem.location,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    iconTheme: const IconThemeData(color: Colors.white),
                    centerTitle: true,
                    title: const Icon(
                      Icons.terrain,
                      size: 40,
                    ),
                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.pending,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                DetailsRatingBar(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20), 
                        child: Text (
                         'About ${selectedItem.name}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text (
                          selectedItem.description,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                       ),
                      )
                    ],
                  ),
                ),
                DetailsBottomAction()
              ],
            )
          )
        ],
      )
    );
  }
}


/* Widgets */

class AppHeader extends StatelessWidget {

  @override
  Widget build (BuildContext context){

    return Container(
      padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://avatars.githubusercontent.com/u/5081804?v=4',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello, Roman',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Good morning',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 12
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppSearch extends StatelessWidget{

  @override
  Widget build (BuildContext context){

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discover',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900
            ),
          ),
          const SizedBox( height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Search',
                         style: TextStyle(
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                )
              ),
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AppMountListView extends StatelessWidget{

  @override
  Widget build (BuildContext context){

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mountItems.length,
        itemBuilder: (context, index){

          MountModel currentMount = mountItems[index];

          return Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(currentMount.path),
                fit: BoxFit.cover,
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentMount.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentMount.location,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppCategoryList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      child: Column(
       children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'See More',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index){

                CategoryModel currentCategory = categories[index];

                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentCategory.icon,
                        color: mainColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        currentCategory.category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          )
       ],
      )
    );
  }
}

// Widget Class
class AppBottomBar extends StatefulWidget {

  @override
  AppBottomBarState createState() => AppBottomBarState();
}

// State Class
class AppBottomBarState extends State<AppBottomBar> {

  List<AppBottomBarItem> barItems = [
    AppBottomBarItem(icon: Icons.home, label: 'Home', isSelected: true),
    AppBottomBarItem(icon: Icons.explore, label: 'Explore', isSelected: false),
    AppBottomBarItem(icon: Icons.turned_in_not, label: 'Tag', isSelected: false),
    AppBottomBarItem(icon: Icons.person_outline, label: 'Profile', isSelected: false)
  ];

  @override 
  Widget build (BuildContext context){

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset.zero
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate( 
          barItems.length, 
          (index){

            AppBottomBarItem currentMenu = barItems[index];

            Widget menuWidget;

            if (currentMenu.isSelected){
              menuWidget = Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: mainColor
                ),
                child: Row(
                  children: [
                    Icon(currentMenu.icon, color: Colors.white,),
                    const SizedBox(width: 5),
                    Text(currentMenu.label, style: const TextStyle(color: Colors.white),)
                  ],
                ),
              );
            }
            else {
              menuWidget = IconButton(
                onPressed: (){
                  setState(() {
                    // barItems.forEach((AppBottomBarItem item) {
                    //   item.isSelected = item == currentMenu;
                    // });
                    for (AppBottomBarItem item in barItems){
                      item.isSelected = item == currentMenu;
                    }
                  });
                },
                icon: Icon (
                  currentMenu.icon,
                  color: Colors.grey,
                )
              );
            }

            return menuWidget;
          }
        )
      ),
    );
  }
}

class DetailsRatingBar extends StatelessWidget {

  final sampleRatingData = {
    'Rating': '4.6',
    'Price': '\$12',
    'Open': '24hrs'
  };

  @override 
  Widget build (BuildContext context){

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          sampleRatingData.entries.length, 
          (index) => Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Text(
                  sampleRatingData.entries.elementAt(index).key,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  sampleRatingData.entries.elementAt(index).value,
                  style: const TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class DetailsBottomAction extends StatelessWidget {

  @override
  Widget build (BuildContext context){

    return  Padding(
      padding:const  EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0.2),
                splashColor: Colors.white.withOpacity(0.2),
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.all(21),
                  child: const Text(
                    'Book Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: mainColor, width: 2)
            ),
            child: const Icon(
              Icons.turned_in_not,
              color: mainColor,
              size: 25,
            ),
          )
        ],
      )
    );
  }
}