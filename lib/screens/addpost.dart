import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddRecipe extends StatefulWidget {
  AddRecipe({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddRecipeState();
  }
}

class AddRecipeState extends State<AddRecipe> {
  String _recipename;
  String _ingredients;
  String _procedure;
  String _url;
  String _chefname;
  String _nutrients;
  // Food _currentFood;
  String _imageUrl;
  File _imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   super.initState();
  //   // FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context, listen: false);
  //
  //   if (foodNotifier.currentFood != null) {
  //     _currentFood = foodNotifier.currentFood;
  //   } else {
  //     _currentFood = Food();
  //   }
  //
  //   _subingredients.addAll(_currentFood.subIngredients);
  //   _imageUrl = _currentFood.image;
  // }

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("image placeholder");
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400);

    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: _recipename),
      maxLength: 255,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Recipe Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _recipename = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Ingredients'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingredients are Required';
        }

        return null;
      },
      onSaved: (String value) {
        _ingredients = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Procedure'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Procedure is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _procedure = value;
      },
    );
  }

  Widget _builURL() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Youtube Channel link'),
      keyboardType: TextInputType.url,
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Chef Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Chef name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _chefname = value;
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Nutrients'),
      onSaved: (String value) {
        _nutrients = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.065,
        title: Text("Add Recipe"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildEmail(),
                _buildPassword(),
                _builURL(),
                _buildPhoneNumber(),
                _buildCalories(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print(_recipename);
                      print(_ingredients);
                      print(_procedure);
                      print(_url);
                      print(_chefname);
                      print(_nutrients);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
