import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  CustomBottomNavbarState createState() => CustomBottomNavbarState();
}

class CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 68,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFD6D6D6), Color(0xFFADB2BD)],
              ),
            ),
          ),
        ),
        BottomNavigationBar(
          backgroundColor:
              Colors.transparent, // Make the background transparent
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/png/icons/message.png',
                color: Color(0xFF151544), // Replace with your color variable
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/png/icons/home.png',
                color: Color(0xFF151544), // Replace with your color variable
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/png/icons/phone.png',
                color: Color(0xFF151544), // Replace with your color variable
              ),
              label: '',
            ),
          ],
          currentIndex: widget.currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: widget.onItemTapped, // Handle icon taps
        ),
      ],
    );
  }
}
