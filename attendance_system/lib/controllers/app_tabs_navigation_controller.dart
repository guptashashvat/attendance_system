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
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    _children = [
      HomePage(
        location: widget.location ?? args ?? "",
      ),
      //HomePage(),
      HomePage(),
      HomePage()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Urban Co-Operative Bank'),
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
            label: 'Attendance History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Employee Profile',
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
