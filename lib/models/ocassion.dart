// To parse this JSON data, do
//
//     final Occasion = OccasionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, Occasion> OccasionFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, Occasion>(k, Occasion.fromJson(v)));

String OccasionToJson(Map<String, Occasion> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Occasion {
  Occasion({
    required this.applicant,
    required this.cashOrOthers,
    required this.choirRefreshment,
    required this.choirWelfare,
    required this.dateOfPayment,
    required this.dieselPayment,
    required this.giftToChurch,
    required this.honorarium,
    required this.mediaPayment,
    required this.motherUnionPayment,
    required this.nameOfReceiver,
    required this.noOfMinisters,
    required this.ocassionTime,
    required this.occasionDate,
    required this.occasionType,
    required this.priestRefreshment,
    required this.totalAmountPaid,
    required this.totalAmountPaidWords,
    required this.workersRefreshment,
  });

  String applicant;
  String cashOrOthers;
  String choirRefreshment;
  String choirWelfare;
  String dateOfPayment;
  String dieselPayment;
  String giftToChurch;
  String honorarium;
  String mediaPayment;
  String motherUnionPayment;
  String nameOfReceiver;
  String noOfMinisters;
  String ocassionTime;
  String occasionDate;
  String occasionType;
  String priestRefreshment;
  String totalAmountPaid;
  String totalAmountPaidWords;
  String workersRefreshment;

  factory Occasion.fromJson(Map<String, dynamic> json) => Occasion(
        applicant: json["applicant"],
        cashOrOthers: json["cashOrOthers"],
        choirRefreshment: json["choirRefreshment"],
        choirWelfare: json["choirWelfare"],
        dateOfPayment: json["dateOfPayment"],
        dieselPayment: json["dieselPayment"],
        giftToChurch: json["giftToChurch"],
        honorarium: json["honorarium"],
        mediaPayment: json["mediaPayment"],
        motherUnionPayment: json["motherUnionPayment"],
        nameOfReceiver: json["nameOfReceiver"],
        noOfMinisters: json["noOfMinisters"],
        ocassionTime: json["ocassionTime"],
        occasionDate: json["occasionDate"],
        occasionType: json["occasionType"],
        priestRefreshment: json["priestRefreshment"],
        totalAmountPaid: json["totalAmountPaid"],
        totalAmountPaidWords: json["totalAmountPaidWords"],
        workersRefreshment: json["workersRefreshment"],
      );

  Map<String, dynamic> toJson() => {
        "applicant": applicant,
        "cashOrOthers": cashOrOthers,
        "choirRefreshment": choirRefreshment,
        "choirWelfare": choirWelfare,
        "dateOfPayment": dateOfPayment,
        "dieselPayment": dieselPayment,
        "giftToChurch": giftToChurch,
        "honorarium": honorarium,
        "mediaPayment": mediaPayment,
        "motherUnionPayment": motherUnionPayment,
        "nameOfReceiver": nameOfReceiver,
        "noOfMinisters": noOfMinisters,
        "ocassionTime": ocassionTime,
        "occasionDate": occasionDate,
        "occasionType": occasionType,
        "priestRefreshment": priestRefreshment,
        "totalAmountPaid": totalAmountPaid,
        "totalAmountPaidWords": totalAmountPaidWords,
        "workersRefreshment": workersRefreshment,
      };
}
