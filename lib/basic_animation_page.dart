// import 'dart:html';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    // final curvedAnimation = CurvedAnimation(
    //   parent: animationController,
    //   curve: Curves.bounceIn,
    //   reverseCurve: Curves.easeOut,
    // );

    animation = Tween<double>(begin: 0, end: 2 * math.pi)
        .chain(
          CurveTween(curve: Curves.bounceIn),
        )
        .animate(animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.rotate(
        angle: animation.value,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
