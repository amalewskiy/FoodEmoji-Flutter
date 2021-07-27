List allFoods = [
  ["Burger", "images/burger.png", "5"],
  ["Fries", "images/fries.png", "12"],
  ["Cheese", "images/cheese.png", "6"],
  ["Doughnut", "images/doughnut.png", "8"],
  ["HotDog", "images/cheese.png", "3"],
  ["Pizza", "images/pizza.png", "22"],
  ["Popcorn", "images/popcorn.png", "14"],
  ["Sandwich", "images/sandwich.png", "12"],
  ["Taco", "images/taco.png", "7"]
];

List colorsPalette = [
  0xFFCEEC97,
  0xFFF4B393,
  0xFFFC60A8,
  0xFF7A28CB,
  0xFF494368
];

class Data {
  var _ordersNumber = 1;

  get ordersNumber => _ordersNumber;

  set ordersNumber(value) {
    _ordersNumber = value;
  }
}
