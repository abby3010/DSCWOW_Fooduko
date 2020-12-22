import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:provider/provider.dart';

class UserInformation extends StatefulWidget {
  UserInformation({Key key}) : super(key: key);


  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).currentUser();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text("Name:"),
                  trailing: Text(user.displayName??"None"),
                ),
                ListTile(
                  title: Text("Email:"),
                  trailing: Text(user.email),
                ),
                ListTile(
                  title: Text("Profile Picture:"),
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
