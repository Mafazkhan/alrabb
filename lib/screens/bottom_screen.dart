import 'package:alrabb/database/methods.dart';
import 'package:alrabb/screens/home_screen.dart';
import 'package:alrabb/screens/meetings.dart';
import 'package:alrabb/widgets/routing_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final screens = [
    Meeting(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              RoutingPage.goToNext(widget: HomeScreen(), context: context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("AlRabb Academy"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            label: 'Message',
          ),
        ],
      ),
    );
  }
}
