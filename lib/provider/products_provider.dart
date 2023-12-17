import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:takyeef/provider/actypr_class.dart';
import 'package:takyeef/provider/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> _discountItems = [];
  List<AcCategory> _acCategories = [];
  List<Product> _companyProducts = [];
  List<Product> _recommendedProducts = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get discountItems {
    return [..._discountItems];
  }

  List<AcCategory> get acCategory {
    return [..._acCategories];
  }

  List<Product> get companyProducts {
    return [..._companyProducts];
  }

  List<Product> get recommendedProducts {
    return [..._recommendedProducts];
  }

  Future<void> fetchNewProducts() async {
    const url = 'http://tkyeefk.com/api/product.php';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      final List<Product> loadedProducts = [];
      for (Map i in extractedData) {
        loadedProducts.insert(
            0,
            Product(
              id: i['id'],
              title: i['product_name'],
              hPower: i['h_power'],
              coolWarm: i['cool_warm'],
              coolCapacity: i['cool_capacity'],
              warmCapacity: i['warm_capacity'],
              color: i['color'],
              price: i['price'],
              priceDiscount: i['price_discount'],
              technology: i['technology'],
              madeIn: i['made_in'],
              guarantee: i['guarantee'],
              imageUrl: i['image_url'],
              description: i['description'],
            ));
      }
      _items = loadedProducts;
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchDiscountProducts() async {
    const url = 'http://tkyeefk.com/api/product.php/?off=1';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      final List<Product> loadedProducts = [];
      for (Map i in extractedData) {
        loadedProducts.insert(
            0,
            Product(
              id: i['id'],
              title: i['product_name'],
              hPower: i['h_power'],
              coolWarm: i['cool_warm'],
              coolCapacity: i['cool_capacity'],
              warmCapacity: i['warm_capacity'],
              color: i['color'],
              price: i['price'],
              priceDiscount: i['price_discount'],
              technology: i['technology'],
              madeIn: i['made_in'],
              guarantee: i['guarantee'],
              imageUrl: i['image_url'],
              description: i['description'],
            ));
      }
      _discountItems = loadedProducts;
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchCategories() async {
    const url = 'http://tkyeefk.com/api/category.php';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      final List<AcCategory> categories = [];
      for (Map i in extractedData) {
        categories.insert(
            0,
            AcCategory(
              id: i['id'],
              name: i['name'],
            ));
      }
      _acCategories = categories;
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchCompaniesProducts(String id) async {
    final url = 'http://tkyeefk.com/api/products.php/?manufactory=$id';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      final List<Product> loadedProduct = [];
      for (Map i in extractedData) {
        loadedProduct.add(Product(
          id: i['id'],
          title: i['product_name'],
          hPower: i['h_power'],
          coolWarm: i['cool_warm'],
          coolCapacity: i['cool_capacity'],
          warmCapacity: i['warm_capacity'],
          color: i['color'],
          price: i['price'],
          priceDiscount: i['price_discount'],
          technology: i['technology'],
          madeIn: i['made_in'],
          guarantee: i['guarantee'],
          imageUrl: i['image_url'],
          description: i['description'],
        ));
      }
      _companyProducts = loadedProduct;
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> showRecommendation(dynamic hp) async {
    final url = 'http://tkyeefk.com/api/special_product.php/?code=$hp';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      List<Product> recommendation = [];
      for (Map i in extractedData) {
        recommendation.add(Product(
          id: i['id'],
          title: i['product_name'],
          hPower: i['h_power'],
          coolWarm: i['cool_warm'],
          coolCapacity: i['cool_capacity'],
          warmCapacity: i['warm_capacity'],
          color: i['color'],
          price: i['price'],
          priceDiscount: i['price_discount'],
          technology: i['technology'],
          madeIn: i['made_in'],
          guarantee: i['guarantee'],
          imageUrl: i['image_url'],
          description: i['description'],
        ));
      }
      _recommendedProducts = recommendation;
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw (error);
    }
  }
}
