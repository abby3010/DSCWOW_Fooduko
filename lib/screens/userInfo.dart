import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/utils/bottomNavBar.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser();
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            height: (MediaQuery.of(context).size.height) * 0.12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Fooduko",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Name:"),
                  trailing: Text(user.displayName),
                ),
                ListTile(
                  title: Text("Email:"),
                  trailing: Text(user.email),
                ),
                ListTile(
                  title: Text("Name:"),
                  trailing: (user.photoUrl != null)
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
            ),
          ),
        ],
      ),
    );
  }
}
