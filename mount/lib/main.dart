import 'package:flutter/material.dart';

const Color mainColor = Color(0xFFFF5656);

final List<MountModel> mountItems = [
  MountModel(
      path:
          'https://sa.kapamilya.com/absnews/abscbnnews/media/2021/afp/01/17/20210116-mt-semeru-indonesia-ash-afp-s.jpg',
      name: 'Mount Semeru',
      location: 'East Java',
      description:
          'Semeru, or Mount Semeru, is an active volcano in East Java, Indonesia. It is located in the subduction zone, where the Indo-Australia plate subducts under the Eurasia plate. It is the highest mountain on the island of Java.'),
  MountModel(
      path:
          'Semeru, or Mount Semeru, is an active volcano in East Java, Indonesia. It is located in the subduction zone, where the Indo-Australia plate subducts under the Eurasia plate. It is the highest mountain on the island of Java.',
      name: 'Mount Merbaru',
      location: 'Central Java',
      description:
          'Mount Merbabu is a dormant stratovolcano in Central Java province on the Indonesian island of Java. The name Merbabu could be loosely translated as Mountain of Ash from the Javanese combined words; Meru means mountain and awu or abu means ash.'),
  MountModel(
      path: 'https://cdn.dlmag.com/wp-content/uploads/2019/07/maunaloa1.jpg',
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
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
        children: const [],
      ),
    );
  }
}

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
