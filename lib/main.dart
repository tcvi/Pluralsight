import 'package:Pluralsight/Page/Account/SignIn.dart';
import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/Page/BrowsePage.dart';
import 'package:Pluralsight/Page/DowloadPage.dart';
import 'package:Pluralsight/Page/HomePage.dart';
import 'package:Pluralsight/Page/SearchPage.dart';
import 'package:Pluralsight/models/User.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void onItemTapped(int index) {
    if (index == 1 ){
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignIn(),settings: RouteSettings(name: "SignIn")));
    } else {
      setState(() {
        _selectedIndex = index;
        navigatorKey.currentState.popUntil((route) => route.isFirst);
      });
    }
  }

  List<Widget> optionSlected = [
    HomePage(
      title: 'Home',
    ),
    DownLoadsPage(),
    BrowsePase(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: CustomNavigator(
        home: optionSlected[_selectedIndex],
        navigatorKey: navigatorKey,
        pageRoute: PageRoutes.cupertinoPageRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.file_download,
              ),
              label: 'Downloads'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_module,
            ),
            label: "Browse",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[300],
        unselectedItemColor: Colors.white,
        onTap: onItemTapped,
      ),
    );
  }
}
