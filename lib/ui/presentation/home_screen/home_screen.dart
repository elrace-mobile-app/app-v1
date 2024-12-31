import 'package:carousel_slider/carousel_slider.dart';
import 'package:el_race/ui/presentation/landing_screen/bloc/checkin_in_bloc/check_in_bloc.dart';
import 'package:el_race/ui/presentation/landing_screen/bloc/face_id_bloc/face_id_bloc.dart';
import 'package:el_race/ui/presentation/signin/data/model.dart';
import 'package:el_race/utils/color_utils.dart';
import 'package:el_race/utils/orientation_helper.dart';
import 'package:el_race/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/di.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/horizontal_slider_widget.dart';
import '../landing_screen/screens/edit_screen.dart';
import '../task_sheet/task_sheet_screen.dart';
import 'card_tile.dart';

class HomeScreen extends StatefulWidget {
  final LoginResponseModel loginResponseModel;

  const HomeScreen({super.key, required this.loginResponseModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

double _slideVal = 0;
Color _thumbColor = shadowBlueDark;
final _checkInBloc = sl.get<CheckInBloc>();
final _faceIdBloc = FaceIdBloc();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _checkInBloc,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(
                username: widget.loginResponseModel.result != null
                    ? widget.loginResponseModel.result!.data!.name!
                    : 'name',
              ),
              SizedBox(
                height: SizeConfig().getHeight(20),
              ),
              CarouselSlider.builder(
                itemCount: 4,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig().getWidth(10)),
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    height: 160,
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: itemIndex.isEven
                            ? [buttonLight, Colors.white, buttonDark]
                            : [lightGrey, darkGrey],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig().getHeight(0),
                          horizontal: SizeConfig().getWidth(0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20), // Apply the same border radius
                            child: Image.asset(
                              '$imagePrefixPng/slider.png',
                              fit: BoxFit.fitHeight,
                              height: 160,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                options: CarouselOptions(
                  height: 160,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widgetContainer(Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig().getWidth(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CheckInBloc, CheckInState>(
                      bloc: _checkInBloc,
                      buildWhen: (p, c) => c != p && c is CheckedInST,
                      builder: (context, state) {
                        var _slideVAl = 0;

                        return checkIn((val) {
                          if (val == 1) {
                            _faceIdBloc.add(GetAllBioMetricET());
                          }
                          /* setState(() {
                            _slideVal = val;
                            log("_slideVal $_slideVal");
                            if (_slideVal == 1.0) {
                              _thumbColor = Colors.green;
                            } else {
                              _thumbColor = shadowBlueDark;
                            }
                          });*/
                        }, _thumbColor);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    listviewWidget(widget.loginResponseModel, context, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimatedListView(
                                    userName:
                                        widget.loginResponseModel.result != null
                                            ? widget.loginResponseModel.result!
                                                .data!.name!
                                            : 'name',
                                  )));
                    }),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget checkIn(
    /*BuildContext context,*/ Function(double val) value, Color color) {
  return Column(
    children: [
      Text(
        'Slide to check in'.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF1A1A53),
          fontFamily: 'Koulen',
          letterSpacing: 0,
          fontWeight: FontWeight.w700,
        ),
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: GradientSliderWidget(
            onValueChanged: (currentVal) {
              value(currentVal);
            },
          ))
    ],
  );
}

Widget iconShow(IconData icon, String title, List listItems, bool show) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: darkGrey, offset: Offset(2, 4), blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: blue,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: blue, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: show ? white : Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                    color: show ? darkGrey : Colors.transparent,
                                    offset: const Offset(2, 4),
                                    blurRadius: 12)
                              ]),
                          child: Image.asset(listItems[index].icon),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(listItems[index].title)
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: listItems.length),
            )
          ],
        ),
      ),
    ),
  );
}

Widget myRequests(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: darkGrey, offset: Offset(2, 4), blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('$imagePrefixIcons/fav2.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: blue, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 60,
                        width: 320,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: white,
                            boxShadow: const [
                              BoxShadow(
                                  color: darkGrey,
                                  offset: Offset(2, 4),
                                  blurRadius: 12)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('$imagePrefixIcons/fav2.png'),
                              Container(
                                color: darkGrey,
                                width: 2,
                                height: 50,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'ANNUAL LEAVE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: blue),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        color: red,
                                        child: const Center(
                                          child: Text(
                                            '1',
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'ANNUAL LEAVE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: darkGrey,
                                            fontSize: 10),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                color: darkGrey,
                                width: 2,
                                height: 50,
                              ),
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'REQUESTED',
                                    style: TextStyle(
                                        fontSize: 10, color: darkGrey),
                                  ),
                                  Text(
                                    '2 DAYS AGO',
                                    style: TextStyle(
                                        fontSize: 10, color: darkGrey),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: blue, width: 2)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: 3)
          ],
        ),
      ),
    ),
  );
}

Widget bottom(Function() onTapped) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(-1.0, 1.0), // Flip horizontally
        child: Image.asset('assets/png/bottom.png'),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: () {
            onTapped();
          },
          child: Container(
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: lightGrey,
                      offset: const Offset(1, 4),
                      blurRadius: 10)
                ]),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/png/icons/signout.png'),
                    Text(
                      'SIGN OUT',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: blue),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget widgetContainer(Widget data) {
  return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
                color: black.withOpacity(0.2), spreadRadius: 10, blurRadius: 9)
          ],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: data);
}

Widget listviewWidget(
    dynamic loginResponseModel, BuildContext context, Function() onTap) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'My widgets',
            style: TextStyle(
              color: Color(0xFF000F42),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
              onTap: () {
                onTap();
              },
              child: const Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xFF858585),
                  fontSize: 16.57,
                  fontWeight: FontWeight.w500,
                ),
              ))
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      GrayCardComponent(
        mainIcon: 'assets/png/calender_icon.png',
        cardTitle: 'ATTENDANCE',
        isGrayCard: false,
        childWidget: SizedBox(
          width: SizeConfig().getWidth(200),
          height: SizeConfig().getHeight(67),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBulletPoint(
                bulletColor: Color(0xFF1A1A53),
                text: 'Your monthly attendance',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "",
              ),
            ],
          ),
        ),
        // itemIndex: index,
      ),
      const SizedBox(
        height: 20,
      ),
      GrayCardComponent(
        mainIcon: 'assets/png/construction_my_pro.png',
        cardTitle: 'MY PROJECTS',
        isGrayCard: true,
        childWidget: SizedBox(
          width: SizeConfig().getWidth(200),
          height: SizeConfig().getHeight(67),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBulletPoint(
                bulletColor: Color(0xFF00D179),
                text: 'Completed',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "12",
              ),
              CustomBulletPoint(
                bulletColor: Color(0xFFBA1719),
                text: 'In progress ',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "08",
              )
            ],
          ),
        ),
        // itemIndex: index,
      ),
      const SizedBox(
        height: 10,
      ),
      GrayCardComponent(
        mainIcon: 'assets/png/project_req.png',
        cardTitle: 'PROJECT REQUESTS',
        isGrayCard: false,
        childWidget: SizedBox(
          width: SizeConfig().getWidth(200),
          height: SizeConfig().getHeight(67),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBulletPoint(
                bulletColor: Color(0xFF1A1A53),
                text: 'All request',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "12",
              ),
              CustomBulletPoint(
                bulletColor: Colors.yellow,
                text: 'Waiting Approve ',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "08",
              )
            ],
          ),
        ),

        // itemIndex: index,
      ),
      const SizedBox(
        height: 10,
      ),
      GrayCardComponent(
        mainIcon: 'assets/png/my_documents.png',
        cardTitle: 'MY DOCUMENTS',
        isGrayCard: true,
        childWidget: Container(
          width: SizeConfig().getWidth(200),
          height: SizeConfig().getHeight(67),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [Colors.white, Color(0xFF999999)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig().getWidth(55),
                height: SizeConfig().getHeight(42.11),
                child: Image.asset('$imagePrefixIcons/id_card.png'),
              ),
              SizedBox(width: SizeConfig().getWidth(20)),
              SizedBox(
                width: SizeConfig().getWidth(55),
                height: SizeConfig().getHeight(44.40),
                child: Image.asset('$imagePrefixIcons/licnc.png'),
              ),
              SizedBox(width: SizeConfig().getWidth(20)),
              SizedBox(
                width: SizeConfig().getWidth(30),
                height: SizeConfig().getHeight(60.90),
                child: Image.asset('$imagePrefixIcons/pass.png'),
              ),
            ],
          ),
        ),
        // itemIndex: index,
      ),
      const SizedBox(
        height: 10,
      ),
      GrayCardComponent(
        mainIcon: 'assets/png/my_notes.png',
        cardTitle: 'MY NOTES',
        isGrayCard: false,
        childWidget: SizedBox(
          width: SizeConfig().getWidth(200),
          height: SizeConfig().getHeight(67),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBulletPoint(
                bulletColor: Color(0xFF1A1A53),
                text: 'Saved',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "12",
              ),
              CustomBulletPoint(
                bulletColor: Color(0xFFBA1719),
                text: 'Draft ',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "08",
              )
            ],
          ),
        ),
        // itemIndex: index,
      ),
      const SizedBox(
        height: 10,
      ),
      GrayCardComponent(
        onClick: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TaskSheetScreen(loginResponseModel: loginResponseModel)),
          );
          // BlocProvider.of<NavigationBloc>(context).add(
          //     TaskSheetScreen(loginResponseModel: widget.loginResponseModel));
        },
        mainIcon: 'assets/png/clock_icon.png',
        cardTitle: 'TIME SHEET',
        isGrayCard: true,
        childWidget: SizedBox(
          width: SizeConfig().getWidth(200),
          height: SizeConfig().getHeight(67),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBulletPoint(
                bulletColor: Colors.yellow,
                text: 'Waiting Approve ',
                textColor: Color(0xFF1A1A53),
                countColor: Color(0xFFBA1719),
                count: "08",
              )
            ],
          ),
        ),
        // itemIndex: index,
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}

class CustomBulletPoint extends StatelessWidget {
  final Color bulletColor;
  final String text;
  final Color textColor;
  final String count;
  final Color countColor;

  const CustomBulletPoint({
    super.key,
    required this.bulletColor,
    required this.text,
    required this.textColor,
    required this.count,
    required this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Custom bullet design
        Container(
          width: 10,
          height: 10,
          decoration: ShapeDecoration(
            color: bulletColor, // Bullet color
            shape: const OvalBorder(),
          ),
        ),
        const SizedBox(width: 8), // Spacing between bullet and text
        Expanded(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                color: textColor, // Text color
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          count.toUpperCase(),
          style: TextStyle(
              color: countColor, // Count color
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
