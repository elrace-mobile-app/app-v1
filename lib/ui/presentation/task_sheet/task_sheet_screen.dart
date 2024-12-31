import 'dart:developer';

import 'package:el_race/ui/presentation/signin/data/model.dart';
import 'package:el_race/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/di.dart';
import '../../../utils/orientation_helper.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/title_bar_with_icon_and_back_widget.dart';
import '../call_screen/bloc/contact_bloc.dart';

class TaskSheetScreen extends StatefulWidget {
  final LoginResponseModel loginResponseModel;

  const TaskSheetScreen({super.key, required this.loginResponseModel});

  @override
  State<TaskSheetScreen> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheetScreen> {
  final _contactBloc = sl.get<ContactBloc>();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _contactBloc.add(GetEmployeeLisET());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _contactBloc,
      child: BlocListener<ContactBloc, ContactState>(
        bloc: _contactBloc,
        listenWhen: (p, c) => c is ContactLoadingState,
        listener: (context, state) {
          log('state $state');
          if (state is ContactLoadingState) {
            if (state.isLoading == true) {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: SizedBox(
                          height: SizeConfig().getHeight(80),
                          width: SizeConfig().getHeight(80),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ));
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeaderWidget(
                    username: widget.loginResponseModel.result != null
                        ? widget.loginResponseModel.result!.data!.name!
                        : 'name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleBarWithIconAndBackWidget(title: 'TASK SHEET'),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<ContactBloc, ContactState>(
                        bloc: _contactBloc,
                        buildWhen: (p, c) =>
                            c != p && c is ContactLoadingState ||
                            c is EmployeeListLoaded,
                        builder: (context, state) {
                          if (state is EmployeeListLoaded) {
                            return ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: state.empList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var emp = state.empList[index];

                                return TaskSheetPersonWidget(
                                    index: index, emp: emp);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 5,
                                );
                              },
                            );
                          }

                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget contactTile(
    List<Color> color,
    Color textColor,
    bool gradientAlignment,
    String image,
    String name,
    String job,
    String emp,
    String num,
    Function() onTap) {
  List<String> nameParts = name.split(' ');
  log('image $image');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 80,
      width: 350,
      // color: Colors.transparent,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
            colors: color,
            // begin: Alignment(1.00, 0.00),
            // end: Alignment(-1, 0),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 6),
              blurRadius: 5)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            LinearGradient(colors: [darkPeach, lightPeach])),
                    child: Center(
                      child: Image.network(
                          image) /*Image.asset('$imagePrefixIcons/user.png')*/,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig().getWidth(170),
                  child: Text(
                    nameParts[1],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  job,
                  style: TextStyle(color: greyText),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  emp,
                  style: TextStyle(color: greyText),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                height: SizeConfig().getHeight(35),
                width: SizeConfig().getWidth(90),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(0, 6),
                          blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                        colors: [shadowBlueDark, shadowBlueLight])),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Contact me',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig().getTextSize(12)),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class TaskSheetPersonWidget extends StatelessWidget {
  const TaskSheetPersonWidget({super.key, this.index, this.emp});

  final dynamic emp;
  final dynamic index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: ScreenUtil().screenWidth - 20,
          height: 160,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: ScreenUtil().screenWidth - 20,
                  height: 160,
                  child: Image.asset('assets/png/time_sheet_bg.png'),
                ),
              ),
              Positioned(
                left: 12,
                top: 27,
                child: SizedBox(
                  width: ScreenUtil().screenWidth - 20,
                  height: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Color(0xFF151544),
                              fontSize: 29.24,
                              fontFamily: 'Abdoullah Ashgar EL-kharef',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 13),
                              SizedBox(
                                width: ScreenUtil().screenWidth - 180,
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Sherif Fathy Attia Abdelhamed',
                                        style: TextStyle(
                                          color: Color(0xFF1A1A53),
                                          fontSize: 17.92,
                                          fontFamily:
                                              ' Abdoullah Ashgar EL-kharef',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Project Name : Abu Dhabi Horse Stables',
                                        style: TextStyle(
                                          color: Color(0xFFBA1719),
                                          fontSize: 10.78,
                                          fontFamily:
                                              ' Abdoullah Ashgar EL-kharef',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Client : Abu Dhabi Police',
                                        style: TextStyle(
                                          color: Color(0xFFBA1719),
                                          fontSize: 10.78,
                                          fontFamily:
                                              ' Abdoullah Ashgar EL-kharef',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
