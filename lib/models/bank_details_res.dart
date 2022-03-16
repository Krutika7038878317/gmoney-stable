// To parse this JSON data, do
//
//     final bankDetailsRes = bankDetailsResFromJson(jsonString);

import 'dart:convert';

BankDetailsRes bankDetailsResFromJson(String str) => BankDetailsRes.fromJson(json.decode(str));

String bankDetailsResToJson(BankDetailsRes data) => json.encode(data.toJson());

class BankDetailsRes {
  BankDetailsRes({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory BankDetailsRes.fromJson(Map<String, dynamic> json) => BankDetailsRes(
    status: json["status"],
    data:json["data"]!=null? Data.fromJson(json["data"]):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.bankPassword,
    this.bankCode,
    this.accountNo,
    this.accountName,
    this.bankName,
    this.ifsc,
    this.bankVerified,
    this.bankType,
  });

  String? bankPassword;
  String? bankCode;
  String? accountNo;
  String? accountName;
  String? bankName;
  String? ifsc;
  bool? bankVerified;
  String? bankType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bankPassword: json["bank_password"],
    bankCode: json["bank_code"],
    accountNo: json["account_no"],
    accountName: json["account_name"],
    bankName: json["bank_name"],
    ifsc: json["ifsc"],
    bankVerified: json["bank_verified"],
    bankType: json["bank_type"],
  );

  Map<String, dynamic> toJson() => {
    "bank_password": bankPassword,
    "bank_code": bankCode,
    "account_no": accountNo,
    "account_name": accountName,
    "bank_name": bankName,
    "ifsc": ifsc,
    "bank_verified": bankVerified,
    "bank_type": bankType,
  };
}
