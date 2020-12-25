import 'package:flutter/material.dart';
import 'package:fooduko/screens/addNewRecipe.dart';
import 'package:fooduko/screens/homepage.dart';
import 'package:fooduko/screens/userInfo.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;

    // TODO: Add New Routes here.
    if(tabItem == "HomePage")
      child = HomePage();
    else if(tabItem == "AddRecipe")
      child = AddRecipeForm();
    else if(tabItem == "UserInformation")
      child = UserInformation();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}
