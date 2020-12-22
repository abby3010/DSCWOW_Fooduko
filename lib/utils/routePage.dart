import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/utils/tabNavigator.dart';
import 'package:provider/provider.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String _currentPage = "HomePage";
  int _selectedIndex = 0;

  List<String> pageKeys = [
    "HomePage",
    "AddRecipe",
    "UserInformation",
  ];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "HomePage": GlobalKey<NavigatorState>(),
    "AddRecipe": GlobalKey<NavigatorState>(),
    "UserInformation": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser();
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "HomePage") {
            _selectTab("HomePage", 1);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // TODO: Add New Page's Navigator Here
            _buildOffstageNavigator("HomePage"),
            _buildOffstageNavigator("AddRecipe"),
            _buildOffstageNavigator("UserInformation"),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: BottomNavigationBar(
            selectedItemColor: Theme.of(context).accentColor,
            onTap: (int index) {
              _selectTab(pageKeys[index], index);
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                ),
                label: "Add",
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: (user.photoUrl != null)
                    ? CircleAvatar(
                        radius: 16,
                        backgroundColor: _selectedIndex==2? Theme.of(context).accentColor:Colors.transparent,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                      )
                    : CircleAvatar(
                        radius: 18,
                        child: Icon(
                          Icons.account_circle,
                          size: 25,
                        ),
                      ),
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
