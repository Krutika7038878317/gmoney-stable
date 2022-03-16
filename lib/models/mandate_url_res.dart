// To parse this JSON data, do
//
//     final mandateUrlRes = mandateUrlResFromJson(jsonString);

import 'dart:convert';

MandateUrlRes mandateUrlResFromJson(String str) => MandateUrlRes.fromJson(json.decode(str));

String mandateUrlResToJson(MandateUrlRes data) => json.encode(data.toJson());

class MandateUrlRes {
  MandateUrlRes({
    this.status,
    this.data,
  });

  bool? status;
  String? data;

  factory MandateUrlRes.fromJson(Map<String, dynamic> json) => MandateUrlRes(
    status: json["status"],
    data: json["data"]!=null?json["data"]:null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data,
  };
}
