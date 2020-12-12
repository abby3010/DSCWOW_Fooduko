import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:provider/provider.dart';
// import 'package:bed_notes/utils/navdrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context);
    final user = authUser.currentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('B.Ed Notes'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(),
            controller: _controller,
            onSubmitted: (String value) async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Thanks!'),
                    content: Text('You typed "$value".'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Text(
            user.email,
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Upload PDF',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
