// To parse this JSON data, do
//
//     final udharListEntity = udharListEntityFromJson(jsonString);

import 'dart:convert';

UdharListEntity udharListEntityFromJson(String str) =>
    UdharListEntity.fromJson(json.decode(str));

String udharListEntityToJson(UdharListEntity data) =>
    json.encode(data.toJson());

class UdharListEntity {
  UdharListEntity({
    required this.name,
    required this.phoneNumber,
    required this.upiId,
    required this.amount,
    required this.udharType,
  });

  String name;
  String phoneNumber;
  String upiId;
  String amount;
  String udharType;

  factory UdharListEntity.fromJson(Map<String, dynamic> json) =>
      UdharListEntity(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        upiId: json["upiId"],
        amount: json["amount"],
        udharType: json["udharType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "upiId": upiId,
        "amount": amount,
        "udharType": udharType,
      };
}
