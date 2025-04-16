// lib/controllers/order_provider.dart
import 'package:flutter/material.dart';
import 'package:media_desgin_expert_task/models/product_model.dart';
import 'package:media_desgin_expert_task/services/product_services.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';
import 'package:media_desgin_expert_task/utilis/snackbar_utilis.dart';

class OrderProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;


  // Getters
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
 

  // Fetch products from API
  Future<void> fetchProductData() async {
    _isLoading = true;
    notifyListeners();

    try {
       _products.clear(); 
      _products = await ProductService.fetchProducts();
     
    } catch (e) {
      print("Error fetching products: $e");
      // Fallback mock data
       _products.clear(); 
   
      
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add a new product
  bool addProduct(ProductModel product, BuildContext context) {
    try {
      _products.add(product);

      notifyListeners();

      SnackbarUtils.showCustomSnackbar(
        context: context,
        title: "Success",
        message: "Product added successfully",
        backgroundColor: greyColor,
      );

      return true;
    } catch (error) {
      notifyListeners();

      SnackbarUtils.showCustomSnackbar(
        context: context,
        title: "Error",
        message: "$error",
        backgroundColor: redColor,
      );

      return false;
    }
  }

  // Remove a product
  bool removeProduct(int index, context) {
    try {
        if (index >= 0 && index < _products.length) {
      final removedProductName = _products[index].name; // Store name before removing

      _products.removeAt(index);
      notifyListeners();

      SnackbarUtils.showCustomSnackbar(
        context: context,
        title: "Success",
        message: "$removedProductName removed successfully",
      );
    }
      return true;
    } catch (error) {
      SnackbarUtils.showCustomSnackbar(
        context: context,
        title: "Error",
        message: "Product remove failed:$error",
      );
      return false;
    }
  }




  
  void updateProductNotes(int index, String notes) {
    if (index >= 0 && index < products.length) {
      products[index].notes = notes;
      notifyListeners();
    }
  }

  void updateProductImage(int index, String imagePath) {
    if (index >= 0 && index < products.length) {
      products[index].imagePath = imagePath;
      notifyListeners();
    }
  }

  void clearProductNotes(int index) {
    if (index >= 0 && index < products.length) {
      products[index].notes = null;
      notifyListeners();
    }
  }

  void clearProductImage(int index) {
    if (index >= 0 && index < products.length) {
      products[index].imagePath = null;
      notifyListeners();
    }
  }
}
