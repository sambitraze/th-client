import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    this.id,
    this.percentage,
    this.offerCode,
    this.minLimit,
    this.maxLimit,
    this.block,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String percentage;
  String offerCode;
  String minLimit;
  String maxLimit;
  bool block;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["_id"] == null ? null : json["_id"],
    percentage: json["percentage"] == null ? null : json["percentage"],
    offerCode: json["offerCode"] == null ? null : json["offerCode"],
    minLimit: json["minLimit"] == null ? null : json["minLimit"],
    maxLimit: json["maxLimit"] == null ? null : json["maxLimit"],
    block: json["block"] == null ? null : json["block"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "percentage": percentage == null ? null : percentage,
    "offerCode": offerCode == null ? null : offerCode,
    "minLimit": minLimit == null ? null : minLimit,
    "maxLimit": maxLimit == null ? null : maxLimit,
    "block": block == null ? null : block,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}
