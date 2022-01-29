// To parse this JSON data, do
//
//     final Burial = BurialFromJson(jsonString);

import 'dart:convert';

Map<String, Burial> BurialFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Burial>(k, Burial.fromJson(v)));

String BurialToJson(Map<String, Burial> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Burial {
  Burial({
    required this.activity,
    required this.age,
    required this.baptismDate,
    required this.baptismPlace,
    required this.burialDate,
    required this.burialLocation,
    required this.businessAddress,
    required this.confirmationDate,
    required this.confirmationPlace,
    required this.cultStatus,
    required this.dateOfBirth,
    required this.dateOfDeath,
    required this.donate,
    required this.firstApplicant,
    required this.firstApplicantRelationship,
    required this.homeAddress,
    required this.language,
    required this.marriageDate,
    required this.nameOfDeceased,
    required this.otherRequest,
    required this.outingDate,
    required this.partnerName,
    required this.secondApplicant,
    required this.secondApplicantRelationship,
    required this.serviceRequest,
    required this.society,
    required this.stateOfOrigin,
    required this.wakeKeepDate,
  });

  String activity;
  String age;
  DateTime baptismDate;
  String baptismPlace;
  DateTime burialDate;
  String burialLocation;
  String businessAddress;
  DateTime confirmationDate;
  String confirmationPlace;
  String cultStatus;
  DateTime dateOfBirth;
  DateTime dateOfDeath;
  String donate;
  String firstApplicant;
  String firstApplicantRelationship;
  String homeAddress;
  String language;
  DateTime marriageDate;
  String nameOfDeceased;
  String otherRequest;
  DateTime outingDate;
  String partnerName;
  String secondApplicant;
  String secondApplicantRelationship;
  String serviceRequest;
  String society;
  String stateOfOrigin;
  DateTime wakeKeepDate;

  factory Burial.fromJson(Map<String, dynamic> json) => Burial(
        activity: json["activity"],
        age: json["age"],
        baptismDate: DateTime.parse(json["baptismDate"]),
        baptismPlace: json["baptismPlace"],
        burialDate: DateTime.parse(json["burialDate"]),
        burialLocation: json["burialLocation"],
        businessAddress: json["businessAddress"],
        confirmationDate: DateTime.parse(json["confirmationDate"]),
        confirmationPlace: json["confirmationPlace"],
        cultStatus: json["cultStatus"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        dateOfDeath: DateTime.parse(json["dateOfDeath"]),
        donate: json["donate"],
        firstApplicant: json["firstApplicant"],
        firstApplicantRelationship: json["firstApplicantRelationship"],
        homeAddress: json["homeAddress"],
        language: json["language"],
        marriageDate: DateTime.parse(json["marriageDate"]),
        nameOfDeceased: json["nameOfDeceased"],
        otherRequest: json["otherRequest"],
        outingDate: DateTime.parse(json["outingDate"]),
        partnerName: json["partnerName"],
        secondApplicant: json["secondApplicant"],
        secondApplicantRelationship: json["secondApplicantRelationship"],
        serviceRequest: json["serviceRequest"],
        society: json["society"],
        stateOfOrigin: json["stateOfOrigin"],
        wakeKeepDate: DateTime.parse(json["wakeKeepDate"]),
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "age": age,
        "baptismDate": baptismDate.toIso8601String(),
        "baptismPlace": baptismPlace,
        "burialDate": burialDate.toIso8601String(),
        "burialLocation": burialLocation,
        "businessAddress": businessAddress,
        "confirmationDate": confirmationDate.toIso8601String(),
        "confirmationPlace": confirmationPlace,
        "cultStatus": cultStatus,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "dateOfDeath": dateOfDeath.toIso8601String(),
        "donate": donate,
        "firstApplicant": firstApplicant,
        "firstApplicantRelationship": firstApplicantRelationship,
        "homeAddress": homeAddress,
        "language": language,
        "marriageDate": marriageDate.toIso8601String(),
        "nameOfDeceased": nameOfDeceased,
        "otherRequest": otherRequest,
        "outingDate": outingDate.toIso8601String(),
        "partnerName": partnerName,
        "secondApplicant": secondApplicant,
        "secondApplicantRelationship": secondApplicantRelationship,
        "serviceRequest": serviceRequest,
        "society": society,
        "stateOfOrigin": stateOfOrigin,
        "wakeKeepDate": wakeKeepDate.toIso8601String(),
      };
}
