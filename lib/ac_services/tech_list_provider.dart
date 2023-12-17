import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'technician_class.dart';

class Technicians with ChangeNotifier {
  List<Technician> _items = [];

  List<Technician> get items {
    return [..._items];
  }

  Future<void> fetchTechs() async {
    final String url = 'http://tkyeefk.com/api/technicians.php';
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      final List<Technician> loadedTechs = [];
      for (Map i in extractedData) {
        loadedTechs.add(
          Technician(
            id: i['id'],
            name: i['full_name'],
            city: i['city'],
            mobile: i['mobile'],
            address: i['address'],
          ),
        );
      }
      _items = loadedTechs;
      notifyListeners();
      return Future.value();
    } catch (error) {
      throw (error);
    }
  }
}
