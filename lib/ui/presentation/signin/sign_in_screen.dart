import 'dart:developer';

import 'package:el_race/ui/presentation/signin/bloc/sign_in_bloc.dart';
import 'package:el_race/utils/color_utils.dart';
import 'package:el_race/utils/orientation_helper.dart';
import 'package:el_race/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/di.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool val = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _signInBloc = sl.get<SignInBloc>();

  final snackBar = const SnackBar(content: Text('Something went wrong'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signInBloc,
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          log('listner $state');

          if (state is ErrMsg) {
            Navigator.of(context, rootNavigator: true).pop();
            // Navigator.pushReplacementNamed(context, landing,
            //     arguments: {});
            final snackBar2 = SnackBar(content: Text(state.msg));
            ScaffoldMessenger.of(context).showSnackBar(snackBar2);
          }

          if (state is LoadingST) {
            if (state.isLoading) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(25)),
                        height: SizeConfig().getHeight(150),
                        width: SizeConfig().getWidth(150),
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig().getWidth(10)),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                  });
            } else {
              return null;
            }
          }

          if (state is InitialSignedInST) {
            Navigator.pushReplacementNamed(context, landing,
                arguments: state.loginResponse);
          }
        },
        buildWhen: (p, c) => c != p && c is LoadingST,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: ScreenUtil().screenWidth,
                        child: Image.asset('assets/png/top_curve.png'),
                      ),
                      SizedBox(
                          width: ScreenUtil().screenWidth,
                          child: Image.asset(
                            'assets/png/bottom_curve.png',
                            fit: BoxFit.fill,
                          )),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig().getWidth(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          logo(),
                          Text(
                            'sign in to your Account',
                            style: TextStyle(
                                fontSize: SizeConfig().getTextSize(20)),
                          ),
                          SizedBox(
                            height: SizeConfig().getHeight(40),
                          ),
                          textForms('Email ID', 'account.png',
                              usernameController, false),
                          SizedBox(
                            height: SizeConfig().getHeight(40),
                          ),
                          textForms(
                              'Password', 'lock.png', passwordController, true),
                          SizedBox(
                            height: SizeConfig().getHeight(40),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              login(() {
                                _signInBloc.add(SignInET(
                                    email: usernameController.text == ''
                                        ? '1120'
                                        : usernameController.text,
                                    password: passwordController.text == ''
                                        ? 'admin'
                                        : passwordController.text,
                                    deviceId: '987654321'));
                              }),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig().getHeight(40),
                          ),
                          Text(
                            'Contact Support',
                            style: TextStyle(
                                fontSize: SizeConfig().getTextSize(18)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget logo() {
  return Padding(
    padding: const EdgeInsets.only(top: 40),
    child:
        SizedBox(width: 600, child: Image.asset('$imagePrefixIcons/logo.png')),
  );
}

Widget signIn(
    BuildContext context, bool val, Function(bool value) valueFunction) {
  return Container(
    height: 222,
    width: 378,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient:
            LinearGradient(colors: [darkGrey, lightGrey.withOpacity(0.3)])),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          // textForms(context, 'Password', 'lock.png'),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: val,
                    onChanged: (value) {
                      // textForms(context, 'Email ID', 'account.png'),
                      log(value.toString());
                      valueFunction(value!);
                    },
                    activeColor: blue,
                  ),
                  Text(
                    'Remember Password',
                    style: TextStyle(color: blue, fontSize: 11),
                  )
                ],
              ),
              Text(
                'Forgot Password',
                style: TextStyle(color: blue, fontSize: 11),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget textForms(
    String title, String icon, TextEditingController controller, bool obscure) {
  return Container(
      height: SizeConfig().getHeight(55),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          color: white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 4,
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12)
          ]),
      /*width: MediaQuery.of(context).size.width,*/
      child: TextFormField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: title,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            hintStyle:
                TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
            prefixIcon: Image.asset('$imagePrefixIcons/$icon')),
      ));
}

Widget login(Function() onTapped) {
  return GestureDetector(
    onTap: () {
      onTapped();
    },
    child: Container(
      width: SizeConfig().getWidth(140),
      height: SizeConfig().getHeight(40),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [buttonLight, offWhite, buttonDark]),
          borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig().getWidth(15)),
          child: Row(
            children: [
              Text(
                'Sign in',
                style: TextStyle(
                    color: shadowBlueDark,
                    fontSize: SizeConfig().getTextSize(19),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: SizeConfig().getWidth(15),
              ),
              Icon(
                Icons.arrow_forward_outlined,
                color: shadowBlueDark,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
