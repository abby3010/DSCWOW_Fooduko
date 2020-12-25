import 'package:flutter/material.dart';

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  static List<String> ingredientsList = [null];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
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

  /// get ingredients text-fields
  List<Widget> _getIngredients() {
    List<Widget> ingredientsTextFields = [];
    for (int i = 0; i < ingredientsList.length; i++) {
      ingredientsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(child: IngredientTextFields(i)),
            SizedBox(
              width: 10,
            ),
            // we need add button at last ingredient's row
            _addRemoveButton(i == ingredientsList.length - 1, i),
          ],
        ),
      ));
    }
    return ingredientsTextFields;
  }

  /// add or remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all ingredients TextFields
          ingredientsList.insert(index + 1, null);
        } else
          ingredientsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Theme.of(context).cursorColor : Theme.of(context).unselectedWidgetColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text("Add New Recipe"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recipe Name",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                // Recipe name TextField
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Add your Recipe Name",
                    ),
                    validator: (v) {
                      if (v.trim().isEmpty) {
                        return "Give a name to your Recipe!";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Ingredients",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),

                // THe below function creates dynamic textfields
                ..._getIngredients(),

                SizedBox(
                  height: 30,
                ),


                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                    print(ingredientsList);
                  },
                  child: Text(
                    "Upload",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                ),
              ],
            ),
          ),
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
          _AddRecipeFormState.ingredientsList[widget.index] ?? '';
    });
    return TextFormField(
      controller: _ingredientController,
      // save text field data in ingredients list at index
      // whenever text field value changes
      onChanged: (v) => _AddRecipeFormState.ingredientsList[widget.index] = v,
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
