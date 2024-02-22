import 'package:donut_shop/utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? rotationAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
     Utils.mainAppNav.currentState!.pushReplacementNamed('/main');
    });

    return Scaffold(
      backgroundColor: Utils.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: rotationAnimation!,
              child: Image.network(
                Utils.donutLogoWhiteNoText,
                width: 100,
                height: 100,
              ),
            ),
            Image.network(Utils.donutLogoWhiteText, width: 150, height: 150),
          ],
        ),
      ),
    );
  }
}