import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/authentication/firebase_auth_service.dart';
import 'package:fooduko/landingpage.dart';
import 'package:fooduko/screens/addNewRecipe.dart';
import 'package:fooduko/screens/homepage.dart';
import 'package:fooduko/screens/userInfo.dart';
import 'package:fooduko/utils/routePage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => FirebaseAuthService(),
          dispose: (_, AuthService authService) => authService.dispose(),
        ),


      ],
      child: MaterialApp(
        title: 'Fooduko',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => LandingPage(),
          "/home": (context) => RoutePage(),
          "/addRecipe": (context) => AddRecipeForm(),
          "/userInfo": (context) => UserInformation(),
        },
      ),
    );
  }
}
