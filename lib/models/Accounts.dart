// To parse this JSON data, do
//
//     final accounts = accountsFromMap(jsonString);

import 'dart:convert';

class Accounts {
  Accounts({
    this.id,
    this.name,
    this.number,
    this.holderType,
    this.holderId,
    this.type,
    this.associatedWith,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? number;
  String? holderType;
  String? holderId;
  String? type;
  dynamic associatedWith;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Accounts.fromJson(String str) => Accounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Accounts.fromMap(Map<String, dynamic> json) => Accounts(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        number: json["number"] == null ? null : json["number"],
        holderType: json["holder_type"] == null ? null : json["holder_type"],
        holderId: json["holder_id"] == null ? null : json["holder_id"],
        type: json["type"] == null ? null : json["type"],
        associatedWith: json["associated_with"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "number": number == null ? null : number,
        "holder_type": holderType == null ? null : holderType,
        "holder_id": holderId == null ? null : holderId,
        "type": type == null ? null : type,
        "associated_with": associatedWith,
        "status": status == null ? null : status,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
