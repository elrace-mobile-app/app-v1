import 'package:el_race/utils/orientation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  final String username;
  const HeaderWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: SizeConfig().getHeight(100),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey.withOpacity(0.5), Colors.grey])),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: Padding(
                  padding: EdgeInsets.only(right: SizeConfig().getWidth(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/png/spike1.png'),
                      Image.asset('assets/png/spike2.png'),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig().getWidth(15)),
            child: Padding(
              padding: EdgeInsets.only(top: SizeConfig().getHeight(20)),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: SizeConfig().getWidth(10),
                      ),
                      Container(
                        width: SizeConfig().getHeight(50),
                        height: SizeConfig().getWidth(50),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          // image: DecorationImage(
                          //   // image: NetworkImage("https://via.placeholder.com/39x38"),
                          //   fit: BoxFit.fill,
                          // ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const FlutterLogo(),
                      ),
                      // Container(
                      //   height: SizeConfig().getHeight(60),
                      //   width: SizeConfig().getWidth(60),
                      //   decoration: const BoxDecoration(
                      //       shape: BoxShape.circle, color: Colors.white),
                      // ),
                      SizedBox(
                        width: SizeConfig().getWidth(250),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Good Morning, $username',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Icon(CupertinoIcons.bell)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
