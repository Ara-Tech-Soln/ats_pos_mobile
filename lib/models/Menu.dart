// To parse this JSON data, do
//
//     final menu = menuFromMap(jsonString);

import 'dart:convert';

class Menu {
  Menu({
    this.id,
    this.name,
    this.price,
    this.image,
    this.typeId,
    this.categoryId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  dynamic price;
  String? image;
  String? typeId;
  String? categoryId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Menu.fromJson(String str) => Menu.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        image: json["image"] == null ? null : json["image"],
        typeId: json["type_id"] == null ? null : json["type_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        deletedAt: json["deleted_at"],
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
        "price": price == null ? null : price,
        "image": image == null ? null : image,
        "type_id": typeId == null ? null : typeId,
        "category_id": categoryId == null ? null : categoryId,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
