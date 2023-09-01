
  class MenuItem {
    final String name;
    final List<String> ingredients;
    int quantity;

    MenuItem({required this.name, required this.ingredients, this.quantity = 1});
  }