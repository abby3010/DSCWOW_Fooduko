import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _recipename;
  String _ingredients;
  String _procedure;
  String _url;
  String _chefname;
  String _nutrients;
  String _imageUrl;
  File _imageFile;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Recipe Name'),
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
      appBar: AppBar(title: Text("Form Demo")),
      body: Container(
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
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  print(_recipename);
                  print(_ingredients);
                  print(_procedure);
                  print(_url);
                  print(_chefname);
                  print(_nutrients);

                  //Send to API
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}