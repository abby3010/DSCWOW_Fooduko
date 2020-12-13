class FoodItem {
  final String name;
  final String category;

  FoodItem({this.name, this.category});

  List<FoodItem> loadNames() {
    var items = <FoodItem>[
      FoodItem(
        name: "Pasta",
        category: null,
      ),
      FoodItem(
        name: "French Fries",
        category: null,
      ),
      FoodItem(
        name: "Ice Cream",
        category: null,
      ),
      FoodItem(
        name: "Bread",
        category: null,
      ),
      FoodItem(
        name: "Fried Rice",
        category: null,
      ),
      FoodItem(
        name: "Pancakes",
        category: null,
      ),
      FoodItem(
        name: "Burger",
        category: null,
      ),
      FoodItem(
        name: "Pizza",
        category: null,
      ),
      FoodItem(
        name: "Chicken Pot Pie",
        category: "",
      ),
      FoodItem(
        name: "Apple Pie",
        category: "Desert",
      ),
      FoodItem(
        name: "Potato Chips",
        category: "Snacks",
      ),
      FoodItem(
        name: "Chicken",
        category: "Non-veg",
      ),
      FoodItem(
        name: "Salad",
        category: "Healthy meal",
      ),
    ];
  }
}
