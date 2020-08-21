import 'package:flutter/material.dart';

class RotateImage extends StatefulWidget {
  @override
  _RotateImageState createState() => _RotateImageState();
}

class _RotateImageState extends State<RotateImage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  void stopRotate() async {
    await Future.delayed(Duration(seconds: 8));
    animationController.stop();
  }

  void initState() {
    super.initState();

    animationController =  AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animationController.repeat();
    stopRotate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      child: AnimatedBuilder(
        animation: animationController,
        child: Image.asset(
          'images/pokeball.png',
          height: 50,
          width: 50,
        ),
        builder: (BuildContext context, Widget _widget) {
          return Transform.rotate(
            angle: animationController.value *(-6.3),
            child: _widget,
          );
        },
      ),
    );
  }
}
