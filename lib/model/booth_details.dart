// To parse this JSON data, do
//
//     final boothDetails = boothDetailsFromJson(jsonString);

import 'dart:convert';

BoothDetails boothDetailsFromJson(String str) => BoothDetails.fromJson(json.decode(str));

String boothDetailsToJson(BoothDetails data) => json.encode(data.toJson());

class BoothDetails {
  BoothDetails({
    this.booth,
    this.resource,
  });

  List<Booth>? booth;
  List<Resource>? resource;

  factory BoothDetails.fromJson(Map<String, dynamic> json) => BoothDetails(
    booth: List<Booth>.from(json["booth"].map((x) => Booth.fromJson(x))),
    resource: List<Resource>.from(json["Resource"].map((x) => Resource.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "booth": List<dynamic>.from(booth!.map((x) => x.toJson())),
    "Resource": List<dynamic>.from(resource!.map((x) => x.toJson())),
  };
}

class Booth {
  Booth({
    this.boothImage,
    this.aboutTitle,
    this.description,
    this.website,
    this.aboutContent,
  });

  String? boothImage;
  String? aboutTitle;
  String? description;
  String? website;
  String? aboutContent;

  factory Booth.fromJson(Map<String, dynamic> json) => Booth(
    boothImage: json["booth_image"],
    aboutTitle: json["about_title"],
    description: json["description"],
    website: json["website"],
    aboutContent: json["about_content"],
  );

  Map<String, dynamic> toJson() => {
    "booth_image": boothImage,
    "about_title": aboutTitle,
    "description": description,
    "website": website,
    "about_content": aboutContent,
  };
}

class Resource {
  Resource({
    this.linkLink,
    this.linkText,
    this.linkContnent,
    this.linkType,
  });

  String? linkLink;
  String? linkText;
  String? linkContnent;
  String? linkType;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
    linkLink: json["link_link"],
    linkText: json["link_text"],
    linkContnent: json["link_contnent"],
    linkType: json["link_type"],
  );

  Map<String, dynamic> toJson() => {
    "link_link": linkLink,
    "link_text": linkText,
    "link_contnent": linkContnent,
    "link_type": linkType,
  };
}
