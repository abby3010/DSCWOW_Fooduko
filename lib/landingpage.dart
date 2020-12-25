import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/authentication/loginpage.dart';
import 'package:fooduko/screens/addRecipePage.dart';
// import 'package:fooduko/screens/homepage.dart';
import 'package:fooduko/user/user.dart';
import 'package:fooduko/utils/routePage.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<UserCredentials>(
        stream: auth.onAuthStateChanged,
        builder: (_, AsyncSnapshot<UserCredentials> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            return user == null ? LoginPage() : AddRecipePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
