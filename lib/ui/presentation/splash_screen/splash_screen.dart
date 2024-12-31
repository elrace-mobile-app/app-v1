import 'package:el_race/utils/color_utils.dart';
import 'package:el_race/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logo(),
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, dashBoard);
                },
                child: button()),
            bottom()
          ],
        ),
      ),
    );
  }
}

Widget logo() {
  return Stack(
    children: [
      Positioned(right: 0, child: Image.asset('assets/png/top.png')),
      Positioned(
        right: 30,
        child: Hero(
          tag: 'crane',
          child: SizedBox(
              height: 335,
              width: 120,
              child: Image.asset('assets/png/crane.png')),
        ),
      ),
    ],
  );
}

Widget button() {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [black, blue]),
            borderRadius: BorderRadius.circular(30)),
        height: 40,
        width: 200,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 20, right: 30, left: 30),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [shadowBlueDark, shadowBlueLight]),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Center(
              child: Text(
                'Start Now',
                style: TextStyle(color: white, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Hero(
        tag: 'tagline',
        child: Text(
          'ENHANCE YOUR EXPERIENCE WITH US',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: lightGrey),
        ),
      )
    ],
  );
}

Widget bottom() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
            height: 30, child: Image.asset('assets/png/translate.png')),
      ),
      Image.asset('assets/png/bottom.png')
    ],
  );
}
