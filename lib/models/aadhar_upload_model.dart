class AAdharUploadModel {
  bool? status;
  String? data;

  AAdharUploadModel({this.status, this.data});

  AAdharUploadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
