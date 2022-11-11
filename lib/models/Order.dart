// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'dart:convert';

class Order {
  Order({
    this.id,
    this.name,
    this.table,
    this.group,
    this.price,
    this.status,
    this.category,
    this.type,
    this.image,
    this.cartId,
    this.quantity,
    this.progress,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? table;
  String? group;
  dynamic price;
  String? status;
  String? category;
  String? type;
  String? image;
  String? cartId;
  dynamic quantity;
  dynamic progress;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        table: json["table"] == null ? null : json["table"],
        group: json["group"] == null ? null : json["group"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"] == null ? null : json["status"],
        category: json["category"] == null ? null : json["category"],
        type: json["type"] == null ? null : json["type"],
        image: json["image"] == null ? null : json["image"],
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        progress: json["progress"] == null ? null : json["progress"],
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
        "table": table == null ? null : table,
        "group": group == null ? null : group,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "category": category == null ? null : category,
        "type": type == null ? null : type,
        "image": image == null ? null : image,
        "cart_id": cartId == null ? null : cartId,
        "quantity": quantity == null ? null : quantity,
        "progress": progress == null ? null : progress,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
