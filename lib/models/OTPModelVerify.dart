class OTPModelVerify {
  bool? status;
  String? token;
  Data? data;
  String? name;

  OTPModelVerify({this.status, this.token, this.data, this.name});

  OTPModelVerify.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Data {
  String? name;
  int? mobile;
  String? gender;
  String? dob;
  Device? device;

  Data({this.name, this.mobile, this.gender, this.dob, this.device});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    gender = json['gender'];
    dob = json['dob'];
    device =
    json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    return data;
  }
}

class Device {
  Location? location;
  double? lat;
  bool? deviceLogin;
  String? id;
  String? ip;
  String? model;
  String? name;
  String? notificationId;
  String? version;
  String? versionId;
  double? long;
  int? mpin;

  Device(
      {this.location,
        this.lat,
        this.deviceLogin,
        this.id,
        this.ip,
        this.model,
        this.name,
        this.notificationId,
        this.version,
        this.versionId,
        this.long,
        this.mpin});

  Device.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    lat = json['lat'] != null ? checkDouble(json['lat']) : null; //json['lat'];
    deviceLogin = json['device_login'];
    id = json['id'];
    ip = json['ip'];
    model = json['model'];
    name = json['name'];
    notificationId = json['notification_id'];
    version = json['version'];
    versionId = json['version_id'];
    long =
    json['long'] != null ? checkDouble(json['long']) : null; //json['long'];
    mpin = json['mpin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['lat'] = this.lat;
    data['device_login'] = this.deviceLogin;
    data['id'] = this.id;
    data['ip'] = this.ip;
    data['model'] = this.model;
    data['name'] = this.name;
    data['notification_id'] = this.notificationId;
    data['version'] = this.version;
    data['version_id'] = this.versionId;
    data['long'] = this.long;
    data['mpin'] = this.mpin;
    return data;
  }
}

class Location {
  List<double>? coordinates;

  Location({this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
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