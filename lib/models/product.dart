class Product {
  final String name;
  final String category;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final bool isFavourite;
  final String description;

  const Product({
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldPrice,
    this.isFavourite = false,
  });
}

final List<Product> products =[
  const Product(
    name: 'Frock',
    category: 'Ladies Outfit',  
    imageUrl: 'assets/images/dress (1).jpg', 
    price: 2750.00,
    oldPrice: 3000.00,
    isFavourite: true,
    description: '',
  ),
  const Product(
    name: 'Grey t-shirt',
    category: 'Outfit',  
    imageUrl: 'assets/images/dress (3).jpg',
    price: 2500.00,
    oldPrice: 2700.00,
    isFavourite: true,
    description: '',
  ),
  const Product(
    name: 'Out Side t-shirt',
    category: 'Outfit',  
    imageUrl: 'assets/images/dress (2).jpg', 
    price: 1200.00,
    oldPrice: 1500.00,
    description: '',
  ),
  const Product(
    name: 'Moose short',
    category: 'Outfit',  
    imageUrl: 'assets/images/dress (4).jpg', 
    price: 2500.00,
    oldPrice: 2800.00,
    description: '',
  ),
];