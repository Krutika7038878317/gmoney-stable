class AAdharOTPVerifyModel {
  bool? status;
  Data? data;

  AAdharOTPVerifyModel({this.status, this.data});

  AAdharOTPVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? address;
  String? pincode;
  bool? isAadharVerified;

  Data({this.name, this.address, this.pincode, this.isAadharVerified});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    pincode = json['pincode'];
    isAadharVerified = json['is_aadhar_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['is_aadhar_verified'] = this.isAadharVerified;
    return data;
  }
}
