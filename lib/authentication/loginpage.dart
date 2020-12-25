import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/landingpage.dart';
import 'package:fooduko/screens/homepage.dart';
// import 'package:fooduko/screens/homepage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FormType _formType = FormType.login;
  // Checking Submission from the Form
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // logging In
  void validateAndSubmit(BuildContext _context) async {
    print("I'm here");
    final authServiceProvider =
        Provider.of<AuthService>(_context, listen: false);
    final authService = authServiceProvider.getCurrentUser();
    // print("AuthUser::::::::" + authService.currentUser().email);
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          await authService.signInwithEmailPassword(
              emailController.text, passwordController.text);
        } else {
          await authService.createUser(
              emailController.text, passwordController.text);
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_context) => LandingPage()),
        );
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Some error occured!\nPlease Try Again!"),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: FlatButton(
                    child: Text("Try Again"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // Redirecting to register page
  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEDE9EA),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/food_1.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: Column(
                  children: buildTextInputs() + buildSubmitButtons(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildTextInputs() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Fooduko.",
            style: Theme.of(context).textTheme.headline,
          ),
        ],
      ),
      // Email TextField
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: TextFormField(
          controller: emailController,
          decoration:
              InputDecoration(labelText: "Email", hintText: "fooduko@mail.com"),
          validator: (value) {
            if (value.isEmpty) {
              return "Enter Email";
            } else if (!value.contains(RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
              return "Enter valid email address";
            }
            return null;
          },
        ),
      ),

      // Password TextField
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
        child: TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            labelText: "Password",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Enter Password!";
            } else if (value.length < 6) {
              return "Password should be atleast 6 characters!";
            }
            return null;
          },
          obscureText: true,
        ),
      )
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        // Login Button
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: () => validateAndSubmit(context),
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: OutlineButton(
            splashColor: Colors.grey,
            onPressed: () async {
              final authServiceProvider =
                  Provider.of<AuthService>(context, listen: false);
              try {
                await authServiceProvider.signInWithGoogle();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_context) => HomePage()),
                );
                print("login successful");
              } catch (e) {
                print("ERROR::::: $e");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text("Some error occured!\nPlease Try Again!"),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: FlatButton(
                            child: Text("Try Again"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 35.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // Create an Account Panel
        FlatButton(
          child: Text(
            "Create an Account",
            style: TextStyle(fontSize: 22.0),
          ),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        // Sign Up Button
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: () => validateAndSubmit(context),
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        // Create a Login Panel
        FlatButton(
          child: Text(
            "Have an Account? Login",
            style: TextStyle(fontSize: 22.0),
          ),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
