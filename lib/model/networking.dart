// To parse this JSON data, do
//
//     final networking = networkingFromJson(jsonString);

import 'dart:convert';

Networking networkingFromJson(String str) => Networking.fromJson(json.decode(str));

String networkingToJson(Networking data) => json.encode(data.toJson());

class Networking {
  Networking({
    this.status,
    this.chatUser,
  });

  int? status;
  List<Map<String, String>>? chatUser;

  factory Networking.fromJson(Map<String, dynamic> json) => Networking(
    status: json["status"],
    chatUser: List<Map<String, String>>.from(json["chat_user"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "chat_user": List<dynamic>.from(chatUser!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
  };
}
