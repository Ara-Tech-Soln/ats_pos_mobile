// To parse this JSON data, do
//
//     final table = tableFromMap(jsonString);

import 'dart:convert';

class Table {
  Table({
    this.id,
    this.name,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  String? name;
  String? description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Table.fromJson(String str) => Table.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Table.fromMap(Map<String, dynamic> json) => Table(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
