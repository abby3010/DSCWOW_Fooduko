import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  var _firestore = FirebaseFirestore.instance.collection("Ingredients");
  var queryResultSet = [];
  String searchString;
  static List<String> ingredientsList = [null];
  // final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // void _addToDataBase(String name) {
  //   List<String> nameList = [];
  //   for (int i = 0; i < name.length; i++) {
  //     nameList.add(name.substring(0, i).toLowerCase());
  //   }
  //   print(nameList);
  //   FirebaseFirestore.instance.collection("Ingredients").doc(name).set({
  //     "name": name,
  //     "name_list": nameList,
  //   });
  // }


  /// get firends text-fields
  // List<Widget> _getIngredients() {
  //   List<Widget> ingredientsTextFields = [];
  //   for (int i = 0; i < ingredientsList.length; i++) {
  //     ingredientsTextFields.add(
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 5.0),
  //         child: Row(
  //           children: [
  //             Expanded(child: IngredientTextFields(i)),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             // we need add button at last ingredient's row
  //             _addRemoveButton(i == ingredientsList.length - 1, i),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  //   return ingredientsTextFields;
  // }

  /// add / remove button
  // Widget _addRemoveButton(bool add, int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (add) {
  //         // add new text-fields at the top of all ingredients TextFields
  //         ingredientsList.insert(index + 1, null);
  //       } else
  //         ingredientsList.removeAt(index);
  //       setState(() {});
  //     },
  //     child: Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: (add)
  //             ? Theme.of(context).cursorColor
  //             : Theme.of(context).unselectedWidgetColor,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Icon(
  //         (add) ? Icons.add : Icons.remove,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.065,
        title: Text("Add New Recipe"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Recipe Name",
            //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            // ),
            // // Recipe name TextField
            // Padding(
            //   padding: const EdgeInsets.only(right: 32.0),
            //   child: TextFormField(
            //     style: TextStyle(fontSize: 20),
            //     controller: _nameController,
            //     decoration: InputDecoration(
            //       hintText: "Add your Recipe Name",
            //     ),
            //     validator: (v) {
            //       if (v.trim().isEmpty) {
            //         return "Give a name to your Recipe!";
            //       }
            //       return null;
            //     },
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add Ingredients",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),

            TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              style: TextStyle(fontSize: 17),
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 27,
                ),
                filled: true,
                hintText: "Search Ingredients Here",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red, //this has no effect
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).textSelectionColor,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == "")
                  ? _firestore.snapshots()
                  : _firestore
                      .where("name_list", arrayContains: searchString)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                }
                List<ListTile> list = snapshot.data.docs.map((DocumentSnapshot document){
                  return ListTile(
                    title: Text(document["name"]),
                  );
                }).toList();
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  default:
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) =>
                          list[index],
                    );
                }
              },
            ),
            //TODO: Ingredient's TextFields:
            // ..._getIngredients(),
          ],
        ),
      ),
    );
  }
}

class IngredientTextFields extends StatefulWidget {
  final int index;
  IngredientTextFields(this.index);
  @override
  _IngredientTextFieldsState createState() => _IngredientTextFieldsState();
}

class _IngredientTextFieldsState extends State<IngredientTextFields> {
  TextEditingController _ingredientController;
  @override
  void initState() {
    super.initState();
    _ingredientController = TextEditingController();
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _ingredientController.text =
          _AddRecipePageState.ingredientsList[widget.index] ?? '';
    });
    return TextFormField(
      controller: _ingredientController,
      // save text field data in ingredients list at index
      // whenever text field value changes
      onChanged: (v) => _AddRecipePageState.ingredientsList[widget.index] = v,
      decoration: InputDecoration(
        filled: true,
        hintText: "Ingredient ${widget.index}",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, //this has no effect
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (v) {
        if (v.trim().isEmpty) return "Enter Ingredient ${widget.index}";
        return null;
      },
    );
  }
}
