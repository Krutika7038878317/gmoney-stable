// To parse this JSON data, do
//
//     final ifscRes = ifscResFromJson(jsonString);

import 'dart:convert';

IfscRes ifscResFromJson(String str) => IfscRes.fromJson(json.decode(str));

String ifscResToJson(IfscRes data) => json.encode(data.toJson());

class IfscRes {
  IfscRes({
    this.status,
    this.bank,
  });

  bool? status;
  Bank? bank;

  factory IfscRes.fromJson(Map<String, dynamic> json) => IfscRes(
    status: json["status"],
    bank: json["bank"]!=null?Bank.fromJson(json["bank"]):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "bank": bank!.toJson(),
  };
}

class Bank {
  Bank({
    this.id,
    this.netBanking,
    this.debitCard,
  });

  String? id;
  bool? netBanking;
  bool? debitCard;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["_id"],
    netBanking: json["netBanking"],
    debitCard: json["debitCard"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "netBanking": netBanking,
    "debitCard": debitCard,
  };
}
