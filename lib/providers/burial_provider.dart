import 'package:flutter/material.dart';

class BurialProvider with ChangeNotifier {
  String? nameOfDeceased;
  String? age;
  String? homeAddress;
  String? businessAddress;
  String? stateOfOrigin;
  String? baptismPlace;
  DateTime? baptismDate;
  DateTime? dateOfBirth;

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
      String? tcultStatus) async {
    confirmationDate = tconfirmationDate;
    confirmationPlace = tconfirmationPlace;
    marriageDate = tmarriageDate;
    partnerName = tpartnerName;
    dateOfDeath = dateOfDeath;
    burialDate = tburialDate;
    wakeWeepDate = twakeWeepDate;
    society = tsociety;
    activity = tactivity;
    cultStatus = cultStatus;
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

  Future<Map> getFormDataB() async {
    return {};
  }

  Future<Map> getFormDataC() async {
    return {};
  }
}
