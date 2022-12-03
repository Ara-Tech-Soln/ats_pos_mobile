// To parse this JSON data, do
//
//     final card = cardFromMap(jsonString);

import 'dart:convert';

class Card {
  Card({
    this.id,
    this.name,
    this.address,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.balance,
  });

  String? id;
  String? name;
  String? address;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic balance;

  factory Card.fromJson(String str) => Card.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Card.fromMap(Map<String, dynamic> json) => Card(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        balance: json["balance"] == null ? null : json["balance"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "balance": balance == null ? null : balance,
      };
}
