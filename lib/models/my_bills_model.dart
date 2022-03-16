class MyBillsModel {
  bool? status;
  List<Data>? data;

  MyBillsModel({this.status, this.data});

  MyBillsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  Offer? offer;
  LoanCalculation? loanCalculation;
  Merchant? merchant;
  Procedure? procedure;
  Procedure? category;
  Scheme? scheme;
  List<Transaction>? transaction;

  Data(
      {this.sId,
        this.offer,
        this.loanCalculation,
        this.merchant,
        this.procedure,
        this.category,
        this.scheme,
        this.transaction});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
    loanCalculation = json['loanCalculation'] != null
        ? new LoanCalculation.fromJson(json['loanCalculation'])
        : null;
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    procedure = json['procedure'] != null
        ? new Procedure.fromJson(json['procedure'])
        : null;
    category = json['category'] != null
        ? new Procedure.fromJson(json['category'])
        : null;
    scheme =
    json['scheme'] != null ? new Scheme.fromJson(json['scheme']) : null;
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    if (this.loanCalculation != null) {
      data['loanCalculation'] = this.loanCalculation!.toJson();
    }
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    if (this.procedure != null) {
      data['procedure'] = this.procedure!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.scheme != null) {
      data['scheme'] = this.scheme!.toJson();
    }
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offer {
  Check? check;
  String? scheme;
  Null description;
  String? admissionDate;
  double? loanAmount;
  String? validtill;
  String? category;
  String? procedure;

  Offer(
      {this.check,
        this.scheme,
        this.description,
        this.admissionDate,
        this.loanAmount,
        this.validtill,
        this.category,
        this.procedure});

  Offer.fromJson(Map<String, dynamic> json) {
    check = json['check'] != null ? new Check.fromJson(json['check']) : null;
    scheme = json['scheme'];
    description = json['description'];
    admissionDate = json['admissionDate'];
    loanAmount =
    json['loanAmount'] != null ? checkDouble(json['loanAmount']) : null;
    validtill = json['validtill'];
    category = json['category'];
    procedure = json['procedure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.check != null) {
      data['check'] = this.check!.toJson();
    }
    data['scheme'] = this.scheme;
    data['description'] = this.description;
    data['admissionDate'] = this.admissionDate;
    data['loanAmount'] = this.loanAmount;
    data['validtill'] = this.validtill;
    data['category'] = this.category;
    data['procedure'] = this.procedure;
    return data;
  }
}

class Check {
  String? status;

  Check({this.status});

  Check.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class LoanCalculation {
  double? advanceEmiCount;
  double? advanceEmiAmt;
  double? emiAmount;
  double? balanceEmiAmt;
  double? totalEmiCount;
  double? processingFee;
  List<EmiTable>? emiTable;

  LoanCalculation(
      {this.advanceEmiCount,
        this.advanceEmiAmt,
        this.emiAmount,
        this.balanceEmiAmt,
        this.totalEmiCount,
        this.processingFee,
        this.emiTable});

  LoanCalculation.fromJson(Map<String, dynamic> json) {
    advanceEmiCount = json['advance_emi_Count'] != null
        ? checkDouble(json['advance_emi_Count'])
        : null;
    advanceEmiAmt = json['advance_emi_Amt'] != null
        ? checkDouble(json['advance_emi_Amt'])
        : null;
    emiAmount =
    json['emiAmount'] != null ? checkDouble(json['emiAmount']) : null;
    balanceEmiAmt = json['balanceEmiAmt'] != null
        ? checkDouble(json['balanceEmiAmt'])
        : null;
    totalEmiCount = json['totalEmiCount'] != null
        ? checkDouble(json['totalEmiCount'])
        : null;
    processingFee = json['processing_fee'] != null
        ? checkDouble(json['processing_fee'])
        : null;
    if (json['emiTable'] != null) {
      emiTable = <EmiTable>[];
      json['emiTable'].forEach((v) {
        emiTable!.add(new EmiTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advance_emi_Count'] = this.advanceEmiCount;
    data['advance_emi_Amt'] = this.advanceEmiAmt;
    data['emiAmount'] = this.emiAmount;
    data['balanceEmiAmt'] = this.balanceEmiAmt;
    data['totalEmiCount'] = this.totalEmiCount;
    data['processing_fee'] = this.processingFee;
    if (this.emiTable != null) {
      data['emiTable'] = this.emiTable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmiTable {
  double? emiAmount;
  String? emiDate;
  String? sId;

  EmiTable({this.emiAmount, this.emiDate, this.sId});

  EmiTable.fromJson(Map<String, dynamic> json) {
    emiAmount =
    json['emiAmount'] != null ? checkDouble(json['emiAmount']) : null;
    emiDate = json['emiDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emiAmount'] = this.emiAmount;
    data['emiDate'] = this.emiDate;
    data['_id'] = this.sId;
    return data;
  }
}

class Merchant {
  BankDetails? bankDetails;
  String? name;

  Merchant({this.bankDetails, this.name});

  Merchant.fromJson(Map<String, dynamic> json) {
    bankDetails = json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class BankDetails {
  String? ifsc;
  String? accountNo;
  bool? bankVerified;
  String? bankName;
  String? chequeLink;

  BankDetails(
      {this.ifsc,
        this.accountNo,
        this.bankVerified,
        this.bankName,
        this.chequeLink});

  BankDetails.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
    accountNo = json['account_no'];
    bankVerified = json['bank_verified'];
    bankName = json['bank_name'];
    chequeLink = json['cheque_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifsc'] = this.ifsc;
    data['account_no'] = this.accountNo;
    data['bank_verified'] = this.bankVerified;
    data['bank_name'] = this.bankName;
    data['cheque_link'] = this.chequeLink;
    return data;
  }
}

class Procedure {
  String? name;

  Procedure({this.name});

  Procedure.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Scheme {
  String? desc;
  double? policy;

  Scheme({this.desc, this.policy});

  Scheme.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    policy = json['policy'] != null ? checkDouble(json['policy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['policy'] = this.policy;
    return data;
  }
}

class Transaction {
  LoanCalculation? loanCalculation;
  Check? loan;

  Transaction({this.loanCalculation, this.loan});

  Transaction.fromJson(Map<String, dynamic> json) {
    loanCalculation = json['loanCalculation'] != null
        ? new LoanCalculation.fromJson(json['loanCalculation'])
        : null;
    loan = json['loan'] != null ? new Check.fromJson(json['loan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loanCalculation != null) {
      data['loanCalculation'] = this.loanCalculation!.toJson();
    }
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    return data;
  }
}

class LoanCalculationData {
  bool? isCaptured;

  LoanCalculationData({this.isCaptured});

  LoanCalculationData.fromJson(Map<String, dynamic> json) {
    isCaptured = json['isCaptured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCaptured'] = this.isCaptured;
    return data;
  }
}

double checkDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else {
    return value.toDouble();
  }
}
