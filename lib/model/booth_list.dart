// To parse this JSON data, do
//
//     final boothList = boothListFromJson(jsonString);

import 'dart:convert';

List<BoothList> boothListFromJson(String str) => List<BoothList>.from(json.decode(str).map((x) => BoothList.fromJson(x)));

String boothListToJson(List<BoothList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoothList {
  BoothList({
    this.boothId,
    this.boothName,
    this.image,
  });

  int? boothId;
  String? boothName;
  String? image;

  factory BoothList.fromJson(Map<String, dynamic> json) => BoothList(
    boothId: json["booth_id"],
    boothName: json["booth_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "booth_id": boothId,
    "booth_name": boothName,
    "image": image,
  };
}
