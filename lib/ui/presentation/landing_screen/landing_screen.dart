import 'package:el_race/ui/presentation/landing_screen/bloc/location_bloc/location_bloc.dart';
import 'package:el_race/ui/presentation/signin/data/model.dart';
import 'package:el_race/ui/presentation/signin/data/repository.dart';
import 'package:el_race/utils/color_utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_navbar.dart';
import '../call_screen/call_screen.dart';
import '../home_screen/home_screen.dart';

class LandingScreen extends StatefulWidget {
  final LoginResponseModel loginResponseModel;
  const LandingScreen({super.key, required this.loginResponseModel});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var _selectedIndex = 0;
  late List<Widget> _pages;
  final _userRepo = UserRepo();
  String? _deviceId = '';
  final _locationBloc = LocationBloc();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // List of pages or widgets that you want to display for each navigation item
    _pages = [
      const Center(child: Text('Search delegate to be given here')),
      HomeScreen(loginResponseModel: widget.loginResponseModel),
      CallScreen(
        loginResponseModel: widget.loginResponseModel,
      )
    ];
    _locationBloc.add(GetCurrentLocationET());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SafeArea(
        bottom: false,
        child: _pages[_selectedIndex], // Display the corresponding page
      ),
    );
  }
}
