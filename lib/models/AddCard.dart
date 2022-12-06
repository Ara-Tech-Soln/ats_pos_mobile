// To parse this JSON data, do
//
//     final addCard = addCardFromMap(jsonString);

import 'dart:convert';

import 'package:startupapplication/models/Card.dart';

class AddCard {
  AddCard({
    this.card,
    this.message,
  });

  Card? card;
  String? message;

  factory AddCard.fromJson(String str) => AddCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCard.fromMap(Map<String, dynamic> json) => AddCard(
        card: json["card"] == null ? null : Card.fromMap(json["card"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toMap() => {
        "card": card == null ? null : card!.toMap(),
        "message": message == null ? null : message,
      };
}
