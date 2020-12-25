import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/authentication/firebase_auth_service.dart';
import 'package:fooduko/landingpage.dart';
import 'package:fooduko/screens/addNewRecipe.dart';
import 'package:fooduko/screens/homepage.dart';
import 'package:fooduko/screens/userInfo.dart';
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
        debugShowCheckedModeBanner: false,
        title: 'Fooduko',
        theme: ThemeData(
          // primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          primaryColor: Color(0xFF003C7E),
          accentColor: Color(0xFF4487C7),
          textTheme: TextTheme(
              title: TextStyle(color: Colors.blueGrey[800], fontSize: 20, fontWeight: FontWeight.w700,),
              headline: TextStyle(color: Colors.green[700], fontSize: 50, fontWeight: FontWeight.w700,),
            ),
        ),
        // home: LandingPage(),
        initialRoute: "/",
        routes: {
          "/": (context) => LandingPage(),
          "/home": (context) => HomePage(),
          "/addRecipe": (context) => AddRecipeForm(),
          "/userInfo": (context) => UserInformation(),
        },
      ),
    );
  }
}
