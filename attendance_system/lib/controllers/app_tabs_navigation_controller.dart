import 'package:flutter/material.dart';
import 'package:attendance_system/screens/home_page.dart';
import 'package:attendance_system/utilities/constants.dart';

class AppTabsNavigationController extends StatefulWidget {
  AppTabsNavigationController({this.location});
  final location;
  @override
  _AppTabsNavigationControllerState createState() =>
      _AppTabsNavigationControllerState();
}

class _AppTabsNavigationControllerState
    extends State<AppTabsNavigationController> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    //HomePage(),
    HomePage(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kThemeColor,
        unselectedItemColor: Colors.grey,
        //type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          /*BottomNavigationBarItem(
            icon: new Icon(Icons.dashboard),
            label: 'Dashboard',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
