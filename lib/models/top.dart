import 'dart:convert';
import './Item.dart';

Top topFromJson(String str) => Top.fromJson(json.decode(str));

String topToJson(Top data) => json.encode(data.toJson());

class Top {
  Top({
    this.id,
    this.item,
    this.srl,
    this.block,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  Item item;
  String srl;
  bool block;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Top.fromJson(Map<String, dynamic> json) => Top(
    id: json["_id"] == null ? null : json["_id"],
    item: json["item"] == null ? null : Item.fromJson(json["item"]),
    srl: json["srl"] == null ? null : json["srl"],
    block: json["block"] == null ? null : json["block"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "item": item == null ? null : item.toJson(),
    "srl": srl == null ? null : srl,
    "block": block == null ? null : block,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}
