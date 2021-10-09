import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:money_management/home.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Center(
        child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return const SizedBox(
              height: 60,
              width: 220,
              child: Center(
                child: Text(
                  'View Splash Animation',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          openColor: Colors.white,
          closedElevation: 20,
          closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          transitionDuration: const Duration(milliseconds: 700),
          openBuilder: (_, closeContainer) {
            return const SplashScreen1Sub();
          },
        ),
      ),
    );
  }
}

class SplashScreen1Sub extends StatefulWidget {
  const SplashScreen1Sub({Key? key}) : super(key: key);

  @override
  _SplashScreen1SubState createState() => _SplashScreen1SubState();
}

class _SplashScreen1SubState extends State<SplashScreen1Sub>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  AnimationController? _controller;
  Animation<double>? animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller!.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        Navigator.pushReplacement(
            context, PageTransition1(const MyHomePage()));
      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'YOUR APP\'S NAME',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1!.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize,
                width: _width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: Image.asset('assets/images/file_name.png')
                child: const Text(
                  'APP LOGO',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition1 extends PageRouteBuilder {
  final Widget page;

  PageTransition1(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(milliseconds: 2000),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
        curve: Curves.fastLinearToSlowEaseIn,
        parent: animation,
      );
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}

// class SplashScreen1SubHome extends StatelessWidget {
//   const SplashScreen1SubHome({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         brightness: Brightness.dark,
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         title: const Text(
//           'APP NAME',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }