// To parse this JSON data, do
//
//     final livenessFaceModel = livenessFaceModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LivenessFaceModel livenessFaceModelFromJson(String str) => LivenessFaceModel.fromJson(json.decode(str));

String livenessFaceModelToJson(LivenessFaceModel data) => json.encode(data.toJson());

class LivenessFaceModel {
  LivenessFaceModel({
    required this.action,
    required this.completedAt,
    required this.createdAt,
    required this.groupId,
    required this.requestId,
    required this.result,
    required this.status,
    required this.taskId,
    required this.type,
  });

  String action;
  DateTime completedAt;
  DateTime createdAt;
  String groupId;
  String requestId;
  Result result;
  String status;
  String taskId;
  String type;

  factory LivenessFaceModel.fromJson(Map<String, dynamic> json) => LivenessFaceModel(
    action: json["action"],
    completedAt: DateTime.parse(json["completed_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    groupId: json["group_id"],
    requestId: json["request_id"],
    result: Result.fromJson(json["result"]),
    status: json["status"],
    taskId: json["task_id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "completed_at": completedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "group_id": groupId,
    "request_id": requestId,
    "result": result.toJson(),
    "status": status,
    "task_id": taskId,
    "type": type,
  };
}

class Result {
  Result({
    required this.areEyesOpen,
    required this.confidence,
    required this.faceBox,
    required this.faceCoverage,
    required this.faceDetected,
    required this.faceQuality,
    required this.isFaceCropped,
    required this.isLive,
    required this.multipleFacesDetected,
    required this.reviewRequired,
  });

  dynamic areEyesOpen;
  dynamic confidence;
  FaceBox faceBox;
  FaceCoverage faceCoverage;
  bool faceDetected;
  FaceQuality faceQuality;
  dynamic isFaceCropped;
  dynamic isLive;
  dynamic multipleFacesDetected;
  dynamic reviewRequired;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    areEyesOpen: json["are_eyes_open"],
    confidence: json["confidence"],
    faceBox: FaceBox.fromJson(json["face_box"]),
    faceCoverage: FaceCoverage.fromJson(json["face_coverage"]),
    faceDetected: json["face_detected"],
    faceQuality: FaceQuality.fromJson(json["face_quality"]),
    isFaceCropped: json["is_face_cropped"],
    isLive: json["is_live"],
    multipleFacesDetected: json["multiple_faces_detected"],
    reviewRequired: json["review_required"],
  );

  Map<String, dynamic> toJson() => {
    "are_eyes_open": areEyesOpen,
    "confidence": confidence,
    "face_box": faceBox.toJson(),
    "face_coverage": faceCoverage.toJson(),
    "face_detected": faceDetected,
    "face_quality": faceQuality.toJson(),
    "is_face_cropped": isFaceCropped,
    "is_live": isLive,
    "multiple_faces_detected": multipleFacesDetected,
    "review_required": reviewRequired,
  };
}

class FaceBox {
  FaceBox({
    required this.height,
    required this.left,
    required this.top,
    required this.width,
  });

  dynamic height;
  dynamic left;
  dynamic top;
  dynamic width;

  factory FaceBox.fromJson(Map<String, dynamic> json) => FaceBox(
    height: json["height"],
    left: json["left"],
    top: json["top"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "left": left,
    "top": top,
    "width": width,
  };
}

class FaceCoverage {
  FaceCoverage({
    required this.message,
    required this.percentage,
    required this.status,
  });

  dynamic message;
  dynamic percentage;
  dynamic status;

  factory FaceCoverage.fromJson(Map<String, dynamic> json) => FaceCoverage(
    message: json["message"],
    percentage: json["percentage"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "percentage": percentage,
    "status": status,
  };
}

class FaceQuality {
  FaceQuality({
    required this.message,
    required this.status,
  });

  dynamic message;
  dynamic status;

  factory FaceQuality.fromJson(Map<String, dynamic> json) => FaceQuality(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
