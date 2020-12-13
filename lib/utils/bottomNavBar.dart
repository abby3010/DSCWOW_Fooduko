import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser();

    return CurvedNavigationBar(
      index: index,
      height: 50,
      color: Colors.indigo,
      backgroundColor: Colors.transparent,
      items: [
        InkWell(
          child: Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              index = 0;
            });
            Navigator.pushNamed(context, "/addRecipe");
          },
        ),
        InkWell(
          onTap: () {
            setState(() {
              index = 1;
            });
            Navigator.pushNamed(context, screens/addpost.dart);
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              index = 2;
            });
            Navigator.pushNamed(context, "/addRecipe");
          },
          child: (user.photoUrl != null)
              ? CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(user.photoUrl),
                )
              : CircleAvatar(
                  radius: 18,
                  child: Icon(
                    Icons.account_circle,
                    size: 20,
                  ),
                ),
        ),
      ],
      animationDuration: Duration(
        milliseconds: 200,
      ),
      // animationCurve: Curves.bounceInOut,
    );
  }
}
