import 'package:flutter/material.dart';
import 'package:paradise/splash_page.dart';

class Paradise extends StatelessWidget {
  const Paradise({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
