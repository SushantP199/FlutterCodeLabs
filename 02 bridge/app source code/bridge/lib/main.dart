// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

/* Globals */
const Color mainYellow = Color(0xFFFFB02F);
const Color primaryGray = Color(0xFF313131);
const Color secondaryGray = Color(0xFF1C1C1C);
const Color lightGray = Color(0xFF3B3B3B);

final List<AttractionModel> attractions = [
  AttractionModel(
    imgPath: 'https://images.pexels.com/photos/260590/pexels-photo-260590.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    name: 'Golden Gate Bridge',
    location: 'San Francisco, CA',
    description: 'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'
  ),
  AttractionModel(
    imgPath: 'https://images.pexels.com/photos/5627275/pexels-photo-5627275.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    name: 'Brooklyn Bridge',
    location: 'Brooklyn, NY',
    description: 'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'
  ),
  AttractionModel(
    imgPath: 'https://images.pexels.com/photos/5241381/pexels-photo-5241381.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
    name: 'London Bridge',
    location: 'London, UK',
    description: 'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'
  ),
  AttractionModel(
    imgPath: 'https://images.pexels.com/photos/1680247/pexels-photo-1680247.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    name: 'Harbour Bridge',
    location: 'Sydney, AU',
    description: 'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'
  )
];

void main() {
  runApp(
    MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class LandingPage extends StatelessWidget {

  @override 
  Widget build (BuildContext context){

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryGray,
        iconTheme: const IconThemeData(color: mainYellow),
        centerTitle: true,
        title: const Icon(
          Icons.airplanemode_on,
          // color: mainYellow,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.notifications_on_outlined,
                color: Colors.grey,
              )
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: mainYellow,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(20),
          child: const Icon(
            Icons.airplanemode_on,
            size: 80,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryGray, secondaryGray],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderWidget(),
            Expanded(child: AttractionListView()),
            BottomBarWidget()
          ],
        ),
      )
    );
  }
}

class DetailsPage extends StatelessWidget {

  final AttractionModel? selectedModel;

  const DetailsPage({this.selectedModel});

  @override 
  Widget build (BuildContext context){

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(selectedModel!.imgPath!),
                fit: BoxFit.cover
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: mainYellow),
            centerTitle: true,
            title: const Icon(Icons.airplanemode_on),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: (){}, 
                  icon: const Icon(
                    Icons.favorite
                  )
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(selectedModel!.name!, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                Text(selectedModel!.location!, style: const TextStyle(color: mainYellow),),
                const SizedBox(height: 20),
                Text(selectedModel!.description!, style: TextStyle(color: Colors.white.withOpacity(0.7))), 
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      child: const Text(
                        'View Comments',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        color: mainYellow,
                        child: InkWell(
                          onTap: (){},
                          splashColor: Colors.black.withOpacity(0.1),
                          highlightColor: Colors.black.withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: const Text('Use Itinerary', style: TextStyle(color: Colors.black, fontWeight:  FontWeight.bold)),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          
        ],
      )
    );
  }
}

class SplashPage extends StatelessWidget {

  @override 
  Widget build (BuildContext context){

    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LandingPage())
      );
    });

    return Stack(
      children: [
        Container(
          color: mainYellow,
        ),
        const Align(
          alignment: Alignment.center,
          child: Icon(Icons.airplanemode_on, color: Colors.black, size: 80),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
              strokeWidth: 10,
            ),
          ),
        )
      ],
    );
  }
}

/* Widgets */

class HeaderWidget extends StatelessWidget {

  @override 
  Widget build (BuildContext context){

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Where do you",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "want to go ?",
                  style: TextStyle(
                    color: mainYellow,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: lightGray
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 1),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AttractionListView extends StatelessWidget {

  @override 
  Widget build (BuildContext context){

    return ListView.builder(
      padding: const EdgeInsets.only(left: 10),
      scrollDirection: Axis.horizontal,
      itemCount: attractions.length,
      itemBuilder: (context, index) {

        AttractionModel currentAttraction = attractions[index];

        return AttractionCard(attractionModel: currentAttraction);
    });
  }
}

class AttractionCard extends StatelessWidget {

  final AttractionModel? attractionModel;

  const AttractionCard({this.attractionModel});

  @override 
  Widget build (BuildContext context){

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context){
              return DetailsPage(selectedModel: attractionModel,);
            }
          )
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(attractionModel!.imgPath!),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(attractionModel!.name!, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(attractionModel!.location!, style: const TextStyle(color: mainYellow)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarWidget extends StatefulWidget {

  @override 
  BottomBarWidgetState createState(){

    return BottomBarWidgetState();
  }
}

class BottomBarWidgetState extends State<BottomBarWidget> {

  final List<BottomBarModel> _bottomBarItems = [
    BottomBarModel(icon: Icons.explore_outlined, isSelected: true),
    BottomBarModel(icon: Icons.favorite_border, isSelected: false),
    BottomBarModel(icon: Icons.comment_outlined, isSelected: false),
    BottomBarModel(icon: Icons.account_circle_outlined, isSelected: false),
  ];
  @override 
  Widget build (BuildContext context){

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          _bottomBarItems.length,
          (index) {

            var currentMenu = _bottomBarItems[index];

            return IconButton(
              onPressed: (){
                setState(() {
                  _bottomBarItems.forEach((menu) {
                    menu.isSelected = menu == currentMenu;
                  });
                });
              }, 
              icon: Icon(
                currentMenu.icon,
                color: currentMenu.isSelected! ? mainYellow : Colors.grey,
              )
            );
          }
        ),
      ),
    );
  }
}

/* Models */

class AttractionModel {
  String? imgPath;
  String? name;
  String? location;
  String? description;

  AttractionModel({
    this.imgPath,
    this.name,
    this.location,
    this.description
  });
}

class BottomBarModel {
  IconData? icon;
  bool? isSelected;

  BottomBarModel({
    this.icon,
    this.isSelected
  });
}