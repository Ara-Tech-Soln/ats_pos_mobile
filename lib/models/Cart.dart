// To parse this JSON data, do
//
//     final cart = cartFromMap(jsonString);

import 'dart:convert';

import 'package:startupapplication/models/Menu.dart';

class Cart {
  Cart({
    this.id,
    this.tableId,
    this.menuId,
    this.quantity,
    this.status,
    this.group,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.menu,
  });

  String? id;
  String? tableId;
  String? menuId;
  int? quantity;
  String? status;
  String? group;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Menu? menu;

  factory Cart.fromJson(String str) => Cart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cart.fromMap(Map<String, dynamic> json) => Cart(
        id: json["id"] == null ? null : json["id"],
        tableId: json["table_id"] == null ? null : json["table_id"],
        menuId: json["menu_id"] == null ? null : json["menu_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        status: json["status"] == null ? null : json["status"],
        group: json["group"] == null ? null : json["group"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        menu: json["menu"] == null ? null : Menu.fromMap(json["menu"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "table_id": tableId == null ? null : tableId,
        "menu_id": menuId == null ? null : menuId,
        "quantity": quantity == null ? null : quantity,
        "status": status == null ? null : status,
        "group": group == null ? null : group,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "menu": menu == null ? null : menu!.toMap(),
      };
}
