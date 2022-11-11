// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.apiToken,
    this.status,
    this.roles,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  dynamic apiToken;
  bool? status;
  String? roles;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        apiToken: json["api_token"],
        status: json["status"] == null ? null : json["status"],
        roles: json["roles"] == null ? null : json["roles"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "api_token": apiToken,
        "status": status == null ? null : status,
        "roles": roles == null ? null : roles,
      };
}
