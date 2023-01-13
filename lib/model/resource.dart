// To parse this JSON data, do
//
//     final resourceDetails = resourceDetailsFromJson(jsonString);

import 'dart:convert';

List<ResourceDetails> resourceDetailsFromJson(String str) => List<ResourceDetails>.from(json.decode(str).map((x) => ResourceDetails.fromJson(x)));

String resourceDetailsToJson(List<ResourceDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResourceDetails {
  ResourceDetails({
    this.id,
    this.fairId,
    this.boothId,
    this.linkType,
    this.linkText,
    this.linkLink,
    this.linkContnent,
    this.active,
  });

  int? id;
  int? fairId;
  int? boothId;
  int? linkType;
  String? linkText;
  String? linkLink;
  String? linkContnent;
  String? active;

  factory ResourceDetails.fromJson(Map<String, dynamic> json) => ResourceDetails(
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





