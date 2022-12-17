// To parse this JSON data, do
//
//     final videoVault = videoVaultFromJson(jsonString);

import 'dart:convert';

List<VideoVault> videoVaultFromJson(String str) => List<VideoVault>.from(json.decode(str).map((x) => VideoVault.fromJson(x)));

String videoVaultToJson(List<VideoVault> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VideoVault {
  VideoVault({
    this.id,
    this.fairId,
    this.boothId,
    this.linkType,
    this.linkText,
    this.linkLink,
    this.linkContnent,
    this.active,
  });

  String? id;
  String? fairId;
  String? boothId;
  String? linkType;
  String? linkText;
  String? linkLink;
  String? linkContnent;
  String? active;

  factory VideoVault.fromJson(Map<String, dynamic> json) => VideoVault(
    id: json["id"],
    fairId: json["fair_id"],
    boothId: json["booth_id"],
    linkType: json["link_type"],
    linkText: json["link_text"],
    linkLink: json["link_link"],
    linkContnent: json["link_contnent"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fair_id": fairId,
    "booth_id": boothId,
    "link_type": linkType,
    "link_text": linkText,
    "link_link": linkLink,
    "link_contnent": linkContnent,
    "active": active,
  };
}
