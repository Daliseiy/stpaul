import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  Future<void> addTestimony(
      String? name, String? phoneNumber, String? testimony) async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/testimony.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'full_name': name,
          'phone_number': phoneNumber,
          'testimony': testimony
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addContact(
      String? name, String? phoneNumber, String? email, String? message) async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/contacts.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'full_name': name,
          'phone_number': phoneNumber,
          'email': email,
          'message': message,
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
