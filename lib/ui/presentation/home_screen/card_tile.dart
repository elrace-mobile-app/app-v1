import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/color_utils.dart';
import '../../../../../utils/orientation_helper.dart';

class CardTile extends StatelessWidget {
  final int itemIndex;
  const CardTile({super.key, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 345,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: itemIndex.isOdd
                ? [buttonLight, Colors.white, buttonDark]
                : [lightGrey, darkGrey],
          )),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig().getWidth(40),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: itemIndex.isOdd
                          ? [buttonLight, buttonDark.withOpacity(0.2)]
                          : [lightGrey, darkGrey],
                    )),
                child: const SizedBox(
                  height: 160,
                ),
              ),
              /*  SizedBox(
              height: 160,
              child: Row(
                children: [
                  Image.asset('assets/png/spike1.png'),
                  Image.asset('assets/png/spike2.png'),
                ],
              ),
            ),*/
              Container(
                width: SizeConfig().getWidth(40),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: itemIndex.isOdd
                          ? [buttonLight, buttonDark.withOpacity(0.2)]
                          : [lightGrey, darkGrey],
                    )),
                child: const SizedBox(
                  height: 160,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig().getHeight(20),
                horizontal: SizeConfig().getWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 23,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white,
                            Colors.black.withOpacity(0.3), // Shadow color
                          ],
                          center: Alignment.center,
                          radius: 3,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color: shadowBlueDark,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: shadowBlueDark,
                      child: Icon(
                        size: SizeConfig().getTextSize(24),
                        Icons.access_time_filled_rounded,
                        color: white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'My Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig().getTextSize(18),
                        color: shadowBlueDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GrayCardComponent extends StatelessWidget {
  const GrayCardComponent(
      {super.key,
      required this.mainIcon,
      this.onClick,
      required this.cardTitle,
      required this.isGrayCard,
      required this.childWidget});

  final String mainIcon;
  final dynamic onClick;
  final String cardTitle;
  final bool isGrayCard;
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClick();
        },
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    child: isGrayCard
                        ? Image.asset('assets/png/gray_card.png',
                            fit: BoxFit.fill)
                        : Image.asset('assets/png/blue_card.png',
                            fit: BoxFit.fill),
                  ),
                  Positioned(
                    left: 36,
                    top: 41,
                    child: SizedBox(
                      height: SizeConfig().getHeight(43),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig().getWidth(40.26),
                            height: SizeConfig().getHeight(40.31),
                            child: Image.asset(
                              mainIcon,
                              width: SizeConfig().getWidth(40),
                              height: SizeConfig().getHeight(40),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cardTitle.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF151544),
                              fontSize: 18,
                              fontFamily: 'Koulen',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 76,
                      top: 99,
                      child: Column(
                        children: [childWidget],
                      )
                      // child: ,
                      ),
                ],
              ),
            ),
          ],
        ));
  }
}
