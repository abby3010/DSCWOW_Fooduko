import 'package:flutter/material.dart';

class AddRecipeForm extends StatefulWidget {
  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  static List<String> ingredientsList = [null];
  static List<String> stepsList = [null];
  int cookingTime;
  int servings;
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
            _addRemoveButtonIngredient(i == ingredientsList.length - 1, i),
          ],
        ),
      ));
    }
    return ingredientsTextFields;
  }

  List<Widget> _getProcedureSteps() {
    List<Widget> stepsTextFields = [];
    for (int i = 0; i < stepsList.length; i++) {
      stepsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(child: ProcedureTextFields(i)),
            SizedBox(
              width: 10,
            ),
            // we need add button at last ingredient's row
            _addRemoveButtonProcedure(i == stepsList.length - 1, i),
          ],
        ),
      ));
    }
    return stepsTextFields;
  }

  /// add or remove button
  Widget _addRemoveButtonIngredient(bool add, int index) {
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

  /// add or remove button
  Widget _addRemoveButtonProcedure(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all ingredients TextFields
          stepsList.insert(index + 1, null);
        } else
          stepsList.removeAt(index);
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
        toolbarHeight: MediaQuery.of(context).size.height * 0.065,
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
                  "Cooking Time (mins)",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                // Cooking Time TextField
                TextFormField(
                  onSaved: (value){
                    cookingTime = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Eg. 10",
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
                    if (v.trim().isEmpty) return "Enter cooking time";
                    return null;
                  },
                ),

                // Serving TextField
                Text(
                  "Servings",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                // Cooking Time TextField
                TextFormField(
                  onSaved: (value){
                    servings = int.parse(value);
                  } ,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Eg. 2",
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
                    if (v.trim().isEmpty) return "Enter no. of servings";
                    return null;
                  },
                ),


                Text(
                  "Add Ingredients",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),

                // The below function creates dynamic textFields for ingredients
                ..._getIngredients(),

                SizedBox(
                  height: 20,
                ),

                Text(
                  "Procedure",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
            // The below function creates dynamic textFields for steps
                ..._getProcedureSteps(),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                    print(ingredientsList);
                    print(stepsList);
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
        hintText: "Ingredient ${widget.index+1}",
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
        if (v.trim().isEmpty) return "Enter Ingredient ${widget.index+1}";
        return null;
      },
    );
  }
}


class ProcedureTextFields extends StatefulWidget {
  final int index;
  ProcedureTextFields(this.index);
  @override
  _ProcedureTextFieldsState createState() => _ProcedureTextFieldsState();
}

class _ProcedureTextFieldsState extends State<ProcedureTextFields> {
  TextEditingController _stepController;
  @override
  void initState() {
    super.initState();
    _stepController = TextEditingController();
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _stepController.text =
          _AddRecipeFormState.stepsList[widget.index] ?? '';
    });
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1, //Normal textInputField will be displayed
      maxLines: 4,
      controller: _stepController,
      // save text field data in ingredients list at index
      // whenever text field value changes
      onChanged: (v) => _AddRecipeFormState.stepsList[widget.index] = v,
      decoration: InputDecoration(
        filled: true,
        hintText: "Step ${widget.index+1}",
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
        if (v.trim().isEmpty) return "Enter Step ${widget.index+1}";
        return null;
      },
    );
  }
}

// class TextFieldUI extends StatelessWidget {
//
//   void Function(String) onSavedFunction;
//   String hintText;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onSaved: onSavedFunction,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         filled: true,
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.red, //this has no effect
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Theme.of(context).textSelectionColor,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.grey,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.red,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.blue,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//       (validatrMessage!=null)?
//       validator: (v) {
//         if (v.trim().isEmpty) return "Enter no. of servings";
//         return null;
//       },
//
//     );
//   }
// }
