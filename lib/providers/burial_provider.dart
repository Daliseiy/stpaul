import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stpaulanglicanchurh/models/burial.dart';

class BurialProvider with ChangeNotifier {
  List<Burial> _burialData = [];

  List<Burial> get burialData {
    return [..._burialData];
  }

  static String? nameOfDeceased;
  static String? age;
  static String? homeAddress;
  static String? businessAddress;
  static String? stateOfOrigin;
  static String? baptismPlace;
  static DateTime? baptismDate;
  static DateTime? dateOfBirth;

  //Second Data
  DateTime? confirmationDate;
  String? confirmationPlace;
  DateTime? marriageDate;
  String? partnerName;
  DateTime? dateOfDeath;
  DateTime? burialDate;
  DateTime? wakeWeepDate;
  String? society;
  String? activity;
  String? cultStatus;
  DateTime? outingDate;
  String? serviceRequest;

  //Third Data
  String? firstApplicant;
  String? secondApplicant;
  String? firstApplicantRelationship;
  String? secondApplicantRelationship;
  String? language;
  String? donate;
  String? burialLocation;
  String? otherRequest;

  Future<void> setFormDataA(
      String? tnameOfDeceased,
      String? tage,
      String? thomeAddress,
      String? tbusinessAddress,
      String? tstateOfOrigin,
      String? tbaptismPlace,
      DateTime? tbaptismDate,
      DateTime? tdateOfBirth) async {
    nameOfDeceased = tnameOfDeceased;
    age = tage;
    homeAddress = thomeAddress;
    businessAddress = tbusinessAddress;
    stateOfOrigin = tstateOfOrigin;
    baptismPlace = tbaptismPlace;
    baptismDate = tbaptismDate;
    dateOfBirth = tdateOfBirth;
    notifyListeners();
  }

  Future<void> setFormDataB(
      DateTime? tconfirmationDate,
      String? tconfirmationPlace,
      DateTime? tmarriageDate,
      String? tpartnerName,
      DateTime? tdateOfDeath,
      DateTime? tburialDate,
      DateTime? twakeWeepDate,
      String? tsociety,
      String? tactivity,
      String? tcultStatus,
      DateTime? toutingDate,
      String? tserviceRequest) async {
    confirmationDate = tconfirmationDate;
    confirmationPlace = tconfirmationPlace;
    marriageDate = tmarriageDate;
    partnerName = tpartnerName;
    dateOfDeath = tdateOfDeath;
    burialDate = tburialDate;
    wakeWeepDate = twakeWeepDate;
    society = tsociety;
    activity = tactivity;
    cultStatus = tcultStatus;
    outingDate = toutingDate;
    serviceRequest = tserviceRequest;
    notifyListeners();
  }

  Future<void> setFinalForm(
      String? tfirstApplicant,
      String? tsecondApplicant,
      String? tfirstApplicantRelationship,
      String? tsecondApplicantRelationship,
      String? tlanguage,
      String? tdonate,
      String? tburialLocation,
      String? totherRequest) async {
    firstApplicant = tfirstApplicant;
    secondApplicant = tsecondApplicant;
    firstApplicantRelationship = tfirstApplicantRelationship;
    secondApplicantRelationship = tsecondApplicantRelationship;
    language = tlanguage;
    donate = tdonate;
    burialLocation = tburialLocation;
    otherRequest = totherRequest;
    notifyListeners();
  }

  Future<void> submitForm(
      String? tfirstApplicant,
      String? tsecondApplicant,
      String? tfirstApplicantRelationship,
      String? tsecondApplicantRelationship,
      String? tlanguage,
      String? tdonate,
      String? tburialLocation,
      String? totherRequest) async {
    firstApplicant = tfirstApplicant;
    secondApplicant = tsecondApplicant;
    firstApplicantRelationship = tfirstApplicantRelationship;
    secondApplicantRelationship = tsecondApplicantRelationship;
    language = tlanguage;
    donate = tdonate;
    burialLocation = tburialLocation;
    otherRequest = totherRequest;
    notifyListeners();
    await addBurialData().then((value) => print('success'));
  }

  Map getFormData() {
    return {
      'nameOfDeceased': nameOfDeceased,
      'age': age,
      'homeAddress': homeAddress,
      'businessAddress': businessAddress,
      'stateOfOrigin': stateOfOrigin,
      'baptismPlace': baptismPlace,
      'baptismDate': baptismDate,
      'dateOfBirth': dateOfBirth,
    };
  }

  Map getFormDataB() {
    return {
      'confirmationDate': confirmationDate,
      'confirmationPlace': confirmationPlace,
      'marriageDate': marriageDate,
      'partnerName': partnerName,
      'dateOfDeath': dateOfDeath,
      'burialDate': burialDate,
      'wakeKeepDate': wakeWeepDate,
      'society': society,
      'activity': activity,
      'cultStatus': cultStatus,
      'outingDate': outingDate,
      'serviceRequest': serviceRequest,
    };
  }

  Map getFormDataC() {
    return {
      'firstApplicant': firstApplicant,
      'secondApplicant': secondApplicant,
      'firstApplicantRelationship': firstApplicantRelationship,
      'secondApplicantRelationship': secondApplicantRelationship,
      'language': language,
      'donate': donate,
      'burialLocation': burialLocation,
      'otherRequest': otherRequest,
    };
  }

  Future<void> addBurialData() async {
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/burial.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'nameOfDeceased': nameOfDeceased,
          'age': age,
          'homeAddress': homeAddress,
          'businessAddress': businessAddress,
          'stateOfOrigin': stateOfOrigin,
          'baptismPlace': baptismPlace,
          'baptismDate': baptismDate.toString(),
          'dateOfBirth': dateOfBirth.toString(),
          'confirmationDate': confirmationDate.toString(),
          'confirmationPlace': confirmationPlace,
          'marriageDate': marriageDate.toString(),
          'partnerName': partnerName,
          'dateOfDeath': dateOfDeath.toString(),
          'burialDate': burialDate.toString(),
          'wakeKeepDate': wakeWeepDate.toString(),
          'society': society,
          'activity': activity,
          'cultStatus': cultStatus,
          'outingDate': outingDate.toString(),
          'serviceRequest': serviceRequest,
          'firstApplicant': firstApplicant,
          'secondApplicant': secondApplicant,
          'firstApplicantRelationship': firstApplicantRelationship,
          'secondApplicantRelationship': secondApplicantRelationship,
          'language': language,
          'donate': donate,
          'burialLocation': burialLocation,
          'otherRequest': otherRequest,
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchBurialForm() async {
    List<Burial> burialObj = [];
    var url = Uri.parse(
        'https://stpaul-anglican-default-rtdb.firebaseio.com/burial.json');

    var response = await http.get(url);

    var burialData = BurialFromJson(response.body);
    burialData.forEach((key, value) {
      burialObj.add(value);
    });
    _burialData = burialObj;
    notifyListeners();
  }
}
