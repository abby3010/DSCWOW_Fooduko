import 'package:flutter/material.dart';
import 'package:fooduko/authentication/auth_service.dart';
import 'package:fooduko/utils/bottomNavBar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  // int _page = 0;
  // GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthService>(context);
    final user = authUser.currentUser();
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: Column(children: [
                Container(
                  height: 280,
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                              image: NetworkImage(user.photoUrl),
                              fit: BoxFit.fill),
                              ),
                        ),
                        Positioned(
                          bottom: 2,
                          child: Container(
                            padding: EdgeInsets.all(7),
                            height: 60,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Sample Blog",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
              // ],
            ),
          ),
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Upload PDF',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
