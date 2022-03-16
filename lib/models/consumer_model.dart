class ConsumerModel {
  bool? status;
  Data? data;

  ConsumerModel({this.status, this.data});

  ConsumerModel.fromJson(Map<String, dynamic> json) {
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
  Customer? customer;
  List<Cards>? cards;

  Data({this.customer, this.cards});

  Data.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  Identity? identity;
  CreditScore? creditScore;
  Device? device;
  String? sId;
  bool? isDiscrepancy;
  int? mobile;

  Customer(
      {this.identity,
      this.creditScore,
      this.device,
      this.sId,
      this.isDiscrepancy,
      this.mobile});

  Customer.fromJson(Map<String, dynamic> json) {
    identity = json['identity'] != null
        ? new Identity.fromJson(json['identity'])
        : null;
    creditScore = json['credit_score'] != null
        ? new CreditScore.fromJson(json['credit_score'])
        : null;
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
    sId = json['_id'];
    isDiscrepancy = json['is_discrepancy'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.identity != null) {
      data['identity'] = this.identity!.toJson();
    }
    if (this.creditScore != null) {
      data['credit_score'] = this.creditScore!.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    data['_id'] = this.sId;
    data['is_discrepancy'] = this.isDiscrepancy;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Identity {
  PoaDetails? poaDetails;
  String? name;
  String? gender;
  String? dob;

  Identity({this.poaDetails, this.name, this.gender, this.dob});

  Identity.fromJson(Map<String, dynamic> json) {
    poaDetails = json['poa_details'] != null
        ? new PoaDetails.fromJson(json['poa_details'])
        : null;
    name = json['name'];
    gender = json['gender'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poaDetails != null) {
      data['poa_details'] = this.poaDetails!.toJson();
    }
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    return data;
  }
}

class PoaDetails {
  AadharDetails? aadharDetails;
  PanDetails? panDetails;

  PoaDetails({this.aadharDetails, this.panDetails});

  PoaDetails.fromJson(Map<String, dynamic> json) {
    aadharDetails = json['aadhar_details'] != null
        ? new AadharDetails.fromJson(json['aadhar_details'])
        : null;
    panDetails = json['pan_details'] != null
        ? new PanDetails.fromJson(json['pan_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aadharDetails != null) {
      data['aadhar_details'] = this.aadharDetails!.toJson();
    }
    if (this.panDetails != null) {
      data['pan_details'] = this.panDetails!.toJson();
    }
    return data;
  }
}

class AadharDetails {
  bool? isAadharVerified;

  AadharDetails({this.isAadharVerified});

  AadharDetails.fromJson(Map<String, dynamic> json) {
    isAadharVerified = json['is_aadhar_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_aadhar_verified'] = this.isAadharVerified;
    return data;
  }
}

class PanDetails {
  bool? isPanVerified;

  PanDetails({this.isPanVerified});

  PanDetails.fromJson(Map<String, dynamic> json) {
    isPanVerified = json['is_pan_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_pan_verified'] = this.isPanVerified;
    return data;
  }
}

class CreditScore {
  String? score;

  CreditScore({this.score});

  CreditScore.fromJson(Map<String, dynamic> json) {
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    return data;
  }
}

class Device {
  int? mpin;

  Device({this.mpin});

  Device.fromJson(Map<String, dynamic> json) {
    mpin = json['mpin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mpin'] = this.mpin;
    return data;
  }
}

class Cards {
  Limit? limit;
  Mandate? mandate;
  Selfie? selfie;
  BankDetails? bankDetails;
  String? sId;
  bool? cardActive;
  List<CardActiveChecks>? cardActiveChecks;
  String? cardToken;
  String? cardNumber;
  Type? type;

  Cards(
      {this.limit,
      this.mandate,
      this.selfie,
      this.bankDetails,
      this.sId,
      this.cardActive,
      this.cardActiveChecks,
      this.cardToken,
      this.cardNumber,
      this.type});

  Cards.fromJson(Map<String, dynamic> json) {
    limit = json['limit'] != null ? new Limit.fromJson(json['limit']) : null;
    mandate =
        json['mandate'] != null ? new Mandate.fromJson(json['mandate']) : null;
    selfie =
        json['selfie'] != null ? new Selfie.fromJson(json['selfie']) : null;
    bankDetails = json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null;
    sId = json['_id'];
    cardActive = json['card_active'];
    if (json['card_active_checks'] != null) {
      cardActiveChecks = <CardActiveChecks>[];
      json['card_active_checks'].forEach((v) {
        cardActiveChecks!.add(new CardActiveChecks.fromJson(v));
      });
    }
    cardToken = json['cardToken'];
    cardNumber = json['cardNumber'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.limit != null) {
      data['limit'] = this.limit!.toJson();
    }
    if (this.mandate != null) {
      data['mandate'] = this.mandate!.toJson();
    }
    if (this.selfie != null) {
      data['selfie'] = this.selfie!.toJson();
    }
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    data['_id'] = this.sId;
    data['card_active'] = this.cardActive;
    if (this.cardActiveChecks != null) {
      data['card_active_checks'] =
          this.cardActiveChecks!.map((v) => v.toJson()).toList();
    }
    data['cardToken'] = this.cardToken;
    data['cardNumber'] = this.cardNumber;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Limit {
  int? total;
  bool? limit;
  int? utilized;
  bool? mediclaim;
  int? mediclaimLimit;
  int? mediclaimUtilized;
  bool? withdrawal;
  int? withdrawalLimit;
  int? withdrawalUtilized;

  Limit(
      {this.total,
      this.limit,
      this.utilized,
      this.mediclaim,
      this.mediclaimLimit,
      this.mediclaimUtilized,
      this.withdrawal,
      this.withdrawalLimit,
      this.withdrawalUtilized});

  Limit.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    utilized = json['utilized'];
    mediclaim = json['mediclaim'];
    mediclaimLimit = json['mediclaimLimit'];
    mediclaimUtilized = json['mediclaimUtilized'];
    withdrawal = json['withdrawal'];
    withdrawalLimit = json['withdrawalLimit'];
    withdrawalUtilized = json['withdrawalUtilized'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['utilized'] = this.utilized;
    data['mediclaim'] = this.mediclaim;
    data['mediclaimLimit'] = this.mediclaimLimit;
    data['mediclaimUtilized'] = this.mediclaimUtilized;
    data['withdrawal'] = this.withdrawal;
    data['withdrawalLimit'] = this.withdrawalLimit;
    data['withdrawalUtilized'] = this.withdrawalUtilized;
    return data;
  }
}

class Mandate {
  bool? isCreated;

  Mandate({this.isCreated});

  Mandate.fromJson(Map<String, dynamic> json) {
    isCreated = json['is_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_created'] = this.isCreated;
    return data;
  }
}

class Selfie {
  String? link;
  bool? isUploaded;
  bool? isVerified;

  Selfie({this.link, this.isUploaded, this.isVerified});

  Selfie.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    isUploaded = json['is_uploaded'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['is_uploaded'] = this.isUploaded;
    data['is_verified'] = this.isVerified;
    return data;
  }
}

class BankDetails {
  String? accountNo;
  bool? bankVerified;

  BankDetails({this.accountNo, this.bankVerified});

  BankDetails.fromJson(Map<String, dynamic> json) {
    accountNo = json['account_no'];
    bankVerified = json['bank_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_no'] = this.accountNo;
    data['bank_verified'] = this.bankVerified;
    return data;
  }
}

class CardActiveChecks {
  String? name;
  int? sort;
  bool? required;
  bool? uploaded;
  bool? verified;
  String? sId;

  CardActiveChecks(
      {this.name,
      this.sort,
      this.required,
      this.uploaded,
      this.verified,
      this.sId});

  CardActiveChecks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sort = json['sort'];
    required = json['required'];
    uploaded = json['uploaded'];
    verified = json['verified'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sort'] = this.sort;
    data['required'] = this.required;
    data['uploaded'] = this.uploaded;
    data['verified'] = this.verified;
    data['_id'] = this.sId;
    return data;
  }
}

class Type {
  String? sId;
  int? type;
  String? name;
  String? cardImage;

  Type({this.sId, this.type, this.name, this.cardImage});

  Type.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    name = json['name'];
    cardImage = json['card_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['card_image'] = this.cardImage;
    return data;
  }
}
