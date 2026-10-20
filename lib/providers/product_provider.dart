import 'package:aula_provider/models/product.dart';
import 'package:aula_provider/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier{
  final ProductService _productService;

  ProductProvider(this._productService);

  List<String> _categories = [];
  List<Product> _products = [];
  bool _isLoading = false;

  List<String> get categories => List.unmodifiable(_categories);
  List<String> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
        notifyListeners();
    
    final result = await Future.wait([
      _productService.fetchCategories(),
    _productService.fetchProducts(),
    ]);
    _categories = result[0] as List<String>;
    _products = result[1] as List<Product>;
    _isLoading = false;
    notifyListeners();
  }
}
