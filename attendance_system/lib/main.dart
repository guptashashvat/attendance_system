import 'screens/sign_in.dart';
import 'screens/home_page.dart';
import 'controllers/app_tabs_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'http/mock_client.dart';
import 'package:http/http.dart' as http;
import 'utilities/constants.dart';

final http.Client httpClient = MockClient();

void main() {
  runApp(MyApp());
}

final routeDetailsArray = [
  RouteDetails(
    name: 'Sign in',
    route: '/sign_in',
    builder: (context) => SignIn(
      httpClient: httpClient,
    ),
  ),
  RouteDetails(
    name: 'Home Page',
    route: '/home_page',
    builder: (context) => HomePage(),
  ),
  RouteDetails(
    name: 'Tabs',
    route: '/tabs',
    builder: (context) => AppTabsNavigationController(),
  ),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Co-operative Bank',
      theme: ThemeData(
        primaryColor: kThemeColor,
        fontFamily: 'Montserrat',
      ),
      routes: Map.fromEntries(
        routeDetailsArray.map(
          (d) => MapEntry(
            d.route,
            d.builder,
          ),
        ),
      ),
      initialRoute: '/sign_in',
    );
  }
}

class RouteDetails {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const RouteDetails({this.name, this.route, this.builder});
}
