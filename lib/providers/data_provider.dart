import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stpaulanglicanchurh/constant.dart';
import 'package:stpaulanglicanchurh/models/dataclass.dart';

class DataProvider with ChangeNotifier {
  List<Testimony> _testimonies = [];
  List<Contact> _contacts = [];
  List<Event> _events = [];

  List<Testimony> get testimony {
    return [..._testimonies];
  }

  List<Testimony> get homeTestimony {
    return _testimonies.where((element) => element.isVisible).toList();
  }

  List<Contact> get contacts {
    return [..._contacts];
  }

  List<Event> get events {
    return [..._events];
  }

  Future<void> fetchTestimony() async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/testimony.json');
    try {
      final List<Testimony> loadedTestimony = [];
      final response = await http.get(url).then((response) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        if (data == null) {
          return;
        }
        data.forEach((key, value) {
          loadedTestimony.add(Testimony(key, value['full_name'],
              value['phone_number'], value['testimony'], value['isVisible']));
        });
        _testimonies = loadedTestimony;
      });
      print(_testimonies);
    } catch (err) {
      throw err;
    }
  }

  Future<void> fetchContacts() async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/contacts.json');
    try {
      final response = await http.get(url).then((response) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        data.forEach((key, value) {
          _contacts.add(Contact(value['full_name'], value['phone_number'],
              value['email'], value['message']));
        });
      });
    } catch (err) {
      throw err;
    }
  }

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
          'testimony': testimony,
          'isVisible': false
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateTestimony(String id, Testimony testimony) async {
    final index = _testimonies.indexWhere((element) => element.id == id);
    if (index >= 0) {
      var url = Uri.parse(
          'https://stpaul-anglican-default-rtdb.firebaseio.com/testimony/$id.json');
      await http.patch(url,
          body: json.encode({'isVisible': testimony.isVisible}));
      _testimonies[index] = testimony;
      notifyListeners();
    } else {
      print('..');
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

  Future<void> addEvent(String title, DateTime date, TimeOfDay time) async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/events.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': title,
          'date': stringdateFormat.format(date),
          'time': formatTimeOfDay(time),
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchEvents() async {
    _events.clear();
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/events.json');
    try {
      final response = await http.get(url).then((response) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        data.forEach((key, value) {
          _events.add(Event(key, value['title'], value['date'], value['time']));
        });
      });
    } catch (err) {
      throw err;
    }
  }

  Future<void> deleteEvent(String id) async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/events/$id.json');
    await http.delete(url);
    notifyListeners();
  }
}
