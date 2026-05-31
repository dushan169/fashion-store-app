import 'package:fashion_store_app/models/product.dart';
import 'package:fashion_store_app/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository _repo = ProductRepository();

  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isLoading = true.obs;
  final RxDouble minPrice = 0.0.obs;
final RxDouble maxPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    _repo.getProducts().listen((products) {
      allProducts.value = products;
      _applyFilter();
      isLoading.value = false;
    });
  }

  final RxString searchQuery = ''.obs;

void searchProducts(String query) {
  searchQuery.value = query;
  _applyFilter();
}

void filterByPrice(double? min, double? max) {
  minPrice.value = min ?? 0;
  maxPrice.value = max ?? 0;
  _applyFilter();
}

void _applyFilter() {
  var products = allProducts.toList();

  if (selectedCategory.value != 'All') {
    products = products
        .where((p) => p.category == selectedCategory.value)
        .toList();
  }

  if (searchQuery.value.isNotEmpty) {
    products = products
        .where((p) =>
            p.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            p.category.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  if (minPrice.value > 0) {
    products = products.where((p) => p.price >= minPrice.value).toList();
  }

  if (maxPrice.value > 0) {
    products = products.where((p) => p.price <= maxPrice.value).toList();
  }

  filteredProducts.value = products;
}
  Future<void> loadCategories() async {
    final cats = await _repo.getCategories();
    categories.value = cats;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    _applyFilter();
  }
}
