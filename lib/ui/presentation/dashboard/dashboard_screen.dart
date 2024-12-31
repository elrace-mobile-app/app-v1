import 'dart:developer';

import 'package:el_race/ui/presentation/dashboard/data/services_model.dart';
import 'package:el_race/utils/color_utils.dart';
import 'package:el_race/utils/string_utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

Widget topSection(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [
        Hero(
          tag: 'crane',
          child: SizedBox(
              height: 272,
              width: 76,
              child: Image.asset('assets/png/crane.png')),
        ),
        Positioned(
          bottom: 60,
          left: 80,
          child: Hero(
            tag: 'tagline',
            child: Text(
              'ENHANCE YOUR EXPERIENCE WITH US',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: lightGrey),
            ),
          ),
        ),
        Positioned(right: 0, child: Image.asset('assets/png/top.png')),
        Positioned(
          right: 10,
          top: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, signIN);
            },
            child: Container(
              width: 110,
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
                        'SIGN IN',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, color: blue),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget services() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1 // 2 columns
            ),
        itemCount: serviceList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                  height: 60, child: Image.asset(serviceList[index].image)),
              const SizedBox(
                height: 5,
              ),
              Text(
                serviceList[index].desc,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              )
            ],
          );
        }),
  );
}

Widget aboutSection(BuildContext context) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [shadowBlueDark, shadowBlueLight])),
        child: const Center(
          child: Text(
            'WHO ARE WE',
            style: TextStyle(color: white),
          ),
        ),
      ),
      Image.asset('$imagePrefixJpg/dashimage.jpg'),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 175,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 175,
                  width: 340,
                  decoration: BoxDecoration(
                      color: offWhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: lightGrey,
                            offset: const Offset(1, 4),
                            blurRadius: 10),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          aboutModel[index].image,
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          aboutModel[index].desc,
                          style: const TextStyle(fontSize: 9),
                          textAlign: TextAlign.start,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: aboutModel.length),
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}

Widget graphs() {
  return Column(
    children: [
      Image.asset('$imagePrefixPng/manpower.png'),
      const SizedBox(
        height: 20,
      )
    ],
  );
}

Widget contacts() {
  return Column(
    children: [
      Image.asset('$imagePrefixIcons/location.png'),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 300,
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 10),
              itemCount: contactList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      contactList[index].loction,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: blue),
                    ),
                    Text(
                      contactList[index].telePhone,
                      style: TextStyle(color: red, fontSize: 12),
                    ),
                    Text(
                      contactList[index].fax,
                      style: TextStyle(color: red, fontSize: 12),
                    ),
                    Text(
                      contactList[index].po,
                      style: TextStyle(color: red, fontSize: 12),
                    ),
                    Text(
                      contactList[index].email,
                      style: TextStyle(color: red, fontSize: 12),
                    )
                  ],
                );
              }),
        ),
      )
    ],
  );
}
