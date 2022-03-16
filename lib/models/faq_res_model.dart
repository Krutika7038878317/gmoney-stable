// To parse this JSON data, do
//
//     final faqRes = faqResFromJson(jsonString);

import 'dart:convert';

FaqRes faqResFromJson(String str) => FaqRes.fromJson(json.decode(str));

String faqResToJson(FaqRes data) => json.encode(data.toJson());

class FaqRes {
  FaqRes({
    this.status,
    this.data,
  });

  bool? status;
  List<FaqDatum>? data;

  factory FaqRes.fromJson(Map<String, dynamic> json) => FaqRes(
    status: json["status"],
    data: json["data"]!=null?List<FaqDatum>.from(json["data"].map((x) => FaqDatum.fromJson(x))):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FaqDatum {
  FaqDatum({
    this.id,
    this.title,
    this.description,
  });

  String? id;
  String? title;
  String? description;

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
  };
}
