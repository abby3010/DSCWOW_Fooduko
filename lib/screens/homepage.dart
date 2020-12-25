import 'package:flutter/material.dart';
// import 'package:fooduko/authentication/auth_service.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    // final authUser = Provider.of<AuthService>(context);
    // final user = authUser.currentUser();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.065,
        title: Text("Fooduko"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: Column(
                children: [
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
                                  image: AssetImage("assets/images/images.jpg"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(7),
                              height: 60,
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0)),
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
                  RaisedButton(
                    child: Text("Page"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/userInfo");
                    },
                  ),
                ],
              ),
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
