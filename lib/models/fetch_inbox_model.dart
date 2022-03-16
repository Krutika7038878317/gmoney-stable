// To parse this JSON data, do
//
//     final fetchInboxModel = fetchInboxModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FetchInboxModel fetchInboxModelFromJson(String str) => FetchInboxModel.fromJson(json.decode(str));

String fetchInboxModelToJson(FetchInboxModel data) => json.encode(data.toJson());

class FetchInboxModel {
  FetchInboxModel({
    required this.dateSent,
    required this.origin,
    required this.body,
  });

  String dateSent;
  String origin;
  String body;

  factory FetchInboxModel.fromJson(Map<String, dynamic> json) => FetchInboxModel(
    dateSent: json["date_sent"],
    origin: json["origin"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "date_sent": dateSent,
    "origin": origin,
    "body": body,
  };
}
