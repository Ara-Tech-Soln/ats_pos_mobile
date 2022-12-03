// To parse this JSON data, do
//
//     final setting = settingFromMap(jsonString);

import 'dart:convert';

class Setting {
  Setting({
    this.id,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Setting.fromJson(String str) => Setting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "value": value == null ? null : value,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
