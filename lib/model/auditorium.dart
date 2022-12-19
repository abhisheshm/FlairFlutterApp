// To parse this JSON data, do
//
//     final auditorium = auditoriumFromJson(jsonString);

import 'dart:convert';

List<Auditorium> auditoriumFromJson(String str) => List<Auditorium>.from(json.decode(str).map((x) => Auditorium.fromJson(x)));

String auditoriumToJson(List<Auditorium> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Auditorium {
  Auditorium({
    this.id,
    this.fairId,
    this.title,
    required this.startDatetime,
    this.endDatetime,
    this.active,
    this.link,
    this.stage,
  });

  String? id;
  String? fairId;
  String? title;
  DateTime startDatetime;
  DateTime? endDatetime;
  String? active;
  String? link;
  String? stage;

  factory Auditorium.fromJson(Map<String, dynamic> json) => Auditorium(
    id: json["id"],
    fairId: json["fair_id"],
    title: json["title"],
    startDatetime: DateTime.parse(json["start_datetime"]),
    endDatetime: DateTime.parse(json["end_datetime"]),
    active: json["active"],
    link: json["link"],
    stage: json["stage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fair_id": fairId,
    "title": title,
    "start_datetime": startDatetime?.toIso8601String(),
    "end_datetime": endDatetime?.toIso8601String(),
    "active": active,
    "link": link,
    "stage": stage,
  };
}
