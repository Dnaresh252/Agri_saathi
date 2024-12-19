class Product {
  final String name;
  final String type;
  final String forecast;
  final double price;
  final double change; // Positive/negative percentage
  final bool isTrendingUp;

  Product({
    required this.name,
    required this.type,
    required this.forecast,
    required this.price,
    required this.change,
    required this.isTrendingUp,
  });
}
final List<Product> products = [
  // Grains
  Product(
    name: "Wheat",
    type: "Grain",
    forecast: "2024/25 Forecast",
    price: 792.17,
    change: 0.34,
    isTrendingUp: true,
  ),
  Product(
    name: "Rice",
    type: "Grain",
    forecast: "2024/25 Forecast",
    price: 538.86,
    change: 0.77,
    isTrendingUp: true,
  ),
  Product(
    name: "Maize",
    type: "Grain",
    forecast: "2024/25 Forecast",
    price: 1220.60,
    change: -1.79,
    isTrendingUp: false,
  ),
  Product(
    name: "Barley",
    type: "Grain",
    forecast: "2024/25 Forecast",
    price: 310.25,
    change: 1.12,
    isTrendingUp: true,
  ),

  // Vegetables
  Product(
    name: "Tomatoes",
    type: "Vegetable",
    forecast: "2024/25 Forecast",
    price: 80.50,
    change: 2.34,
    isTrendingUp: true,
  ),
  Product(
    name: "Potatoes",
    type: "Vegetable",
    forecast: "2024/25 Forecast",
    price: 60.20,
    change: -0.84,
    isTrendingUp: false,
  ),
  Product(
    name: "Carrots",
    type: "Vegetable",
    forecast: "2024/25 Forecast",
    price: 45.80,
    change: 1.50,
    isTrendingUp: true,
  ),
  Product(
    name: "Onions",
    type: "Vegetable",
    forecast: "2024/25 Forecast",
    price: 100.75,
    change: -2.12,
    isTrendingUp: false,
  ),
  Product(
    name: "Spinach",
    type: "Vegetable",
    forecast: "2024/25 Forecast",
    price: 35.30,
    change: 0.95,
    isTrendingUp: true,
  ),

  // Fruits
  Product(
    name: "Apples",
    type: "Fruit",
    forecast: "2024/25 Forecast",
    price: 180.50,
    change: 1.10,
    isTrendingUp: true,
  ),
  Product(
    name: "Bananas",
    type: "Fruit",
    forecast: "2024/25 Forecast",
    price: 40.75,
    change: -0.50,
    isTrendingUp: false,
  ),
  Product(
    name: "Oranges",
    type: "Fruit",
    forecast: "2024/25 Forecast",
    price: 95.40,
    change: 0.65,
    isTrendingUp: true,
  ),
  Product(
    name: "Grapes",
    type: "Fruit",
    forecast: "2024/25 Forecast",
    price: 120.30,
    change: 1.25,
    isTrendingUp: true,
  ),
  Product(
    name: "Mangoes",
    type: "Fruit",
    forecast: "2024/25 Forecast",
    price: 150.80,
    change: -1.00,
    isTrendingUp: false,
  ),

  // Legumes and Pulses
  Product(
    name: "Chickpeas",
    type: "Legume",
    forecast: "2024/25 Forecast",
    price: 240.10,
    change: 1.75,
    isTrendingUp: true,
  ),
  Product(
    name: "Lentils",
    type: "Pulse",
    forecast: "2024/25 Forecast",
    price: 300.50,
    change: -0.95,
    isTrendingUp: false,
  ),
  Product(
    name: "Soybeans",
    type: "Legume",
    forecast: "2024/25 Forecast",
    price: 424.96,
    change: 7.29,
    isTrendingUp: true,
  ),

  // Cash Crops
  Product(
    name: "Sugarcane",
    type: "Cash Crop",
    forecast: "2024/25 Forecast",
    price: 70.40,
    change: 0.85,
    isTrendingUp: true,
  ),
  Product(
    name: "Cotton",
    type: "Cash Crop",
    forecast: "2024/25 Forecast",
    price: 920.75,
    change: -0.55,
    isTrendingUp: false,
  ),
  Product(
    name: "Coffee",
    type: "Cash Crop",
    forecast: "2024/25 Forecast",
    price: 1350.40,
    change: 1.65,
    isTrendingUp: true,
  ),
];

