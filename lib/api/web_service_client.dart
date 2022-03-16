import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gmoney/models/OTPModelVerify.dart';
import 'package:gmoney/models/bank_details_res.dart';
import 'package:gmoney/models/fetch_inbox_model.dart';
import 'package:gmoney/util/constant/constants.dart';
import 'package:gmoney/util/log.dart';
import 'package:gmoney/util/utils.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/aadhar_no_model.dart';
import '../models/liveness_face_model.dart';

enum HttpMethod { HTTP_GET, HTTP_POST, HTTP_PUT }

enum RequestBodyType { TYPE_XX_URLENCODED_FORMDATA, TYPE_JSON, TYPE_MULTIPART }

enum TokenType {
  TYPE_BASIC,
  TYPE_BEARER,
  TYPE_NONE,
  TYPE_DEVICE_TOKEN,
}

enum WebError {
  INTERNAL_SERVER_ERROR,
  ALREADY_EXIST,
  UNAUTHORIZED,
  INVALID_JSON,
  NOT_FOUND,
  UNKNOWN,
  BAD_REQUEST,
  FORBIDDEN
}

///this class handles api calls
class WebServiceClient {
  static const BASE_URL = "https://cardsuat.gmoney.loans/";

  /// login via email or phone
  static Future<dynamic> hitLoginUser(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "login";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) {
      response = value;
    }).catchError((onError) {
      print(onError);
    }).timeout(Duration(seconds: 120), onTimeout: () {
      Log.d("login timeout $response");
    });
    return response;
  }

  /// uploadSMSDump
  static Future<dynamic> uploadSMSDump(Map<String, dynamic> fieldMap) async {
    var url = 'http://ec2-13-233-231-234.ap-south-1.compute.amazonaws.com:3000/storeSMSCore';
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_JSON,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) {
      print("sms responses");
      response = value;
    }).catchError((onError, cause) {
      print("sms responses error");
      print(onError);
      print(cause);
    }).timeout(Duration(seconds: 120), onTimeout: () {
      Log.d("sms timeout $response");
    });
    return response;
  }

  /// profile Image
  static Future<dynamic> hitImageProfile(Map<String, dynamic> fieldMap,
      List<File> file) async {
    var sp = await SharedPreferences.getInstance();
    var id= sp.getString("cardId");
    var url = BASE_URL + "customer/selfie/upload/$id";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_MULTIPART,
        TokenType.TYPE_NONE, fieldMap,
        files: file)
        .then((value) => {
          response = value
        });
    return response;
  }

  /// profile Image
  static Future<dynamic> fetchAadhaarUploadData(Map<String, dynamic> fieldMap,
      List<File> files, [Map<String, File>? fileMap]) async {
    var sp = await SharedPreferences.getInstance();
   var id= sp.getString("cardId");
    var url = BASE_URL + "customer/aadhaar/upload/$id";
    var response;
    await _hitService(url, HttpMethod.HTTP_POST, RequestBodyType.TYPE_MULTIPART,
        TokenType.TYPE_NONE, fieldMap,
        files: files,
    fileMap: fileMap)
        .then((value) => {
      response = value
    });
    return response;
  }

  /// send Otp
  static Future<dynamic> postSendOtp(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "auth/customer/sendOtp";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      DioError errors=error;
      print("outer: ${errors.response}");
    });
    print(response);
    print("response");
    return response;
  }
  /// device info
  static Future<dynamic> postUpdateDeviceInfo(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "customer/device/update";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      DioError errors=error;
      print("outer: ${errors.response}");
    });
    print(response);
    print("response");
    return response;
  }

  /// verify Otp
  static Future<dynamic> postVerifyOtp(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "auth/customer/verifyOtp";
    var responseData;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {responseData = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      DioError errors=error;
      print("outer: ${errors.message}");

    });
    print(responseData.toString());
    print("responses");

    var jsonString = responseData;
    var mobileData = OTPModelVerify.fromJson(jsonString);
    var sp = await SharedPreferences.getInstance();
    sp.setString(PREF_TOKEN, mobileData.token!);
    sp.setBool("userStatus", mobileData.status!);
    sp.setString("userMobile", mobileData.data!.mobile.toString());
    sp.setString("name", mobileData.name!);
    // if (mobileData.data?.device?.mpin != null&&mobileData.data?.device?.mpin!=4321) {
    //   sp.setString("mPin", mobileData.data!.device!.mpin.toString());
    //   sp.setBool("fingerPrintEnabled", mobileData.data!.device!.deviceLogin!);
    // } else {
    //   sp.setString("mPin", "");
    // }

    return responseData;
  }

  /// send adhar Otp
  static Future<dynamic> aadhaarGenerateOtp(
      Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "customer/aadhaar/generateOtp";
    var responseData;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) {
      print("dio success");
    responseData = value;
        var jsonString = responseData;
        var aadhaarData = AadharModel.fromJson(jsonString);
    return aadhaarData;
  })
        .catchError((error, stackTrace) {
      print("dio errors");
          DioError err = error;
          print(err.response?.statusCode.toString());
          print(err.response?.data['message'].toString());
      Utils.instance.showToast(err.response?.data['message'],isBottom: true);
          var response = err.response;
          return err.response?.data['message'];


          // error is SecondError
    print("outer: $error");
    });
    print(responseData.toString());
    print("responses");


  }

  /// send adhar Otp
  static Future<dynamic> aadhaarVerifyOtp(Map<String, dynamic> fieldMap) async {
    var sp = await SharedPreferences.getInstance();
    var id= sp.getString("cardId");
    var url = BASE_URL + "customer/aadhaar/verify/$id";
    var responseData;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {responseData = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      print("outer: $error");
    });
    print(responseData.toString());
    print("responses");

    var jsonString = responseData;
    var mobileData = OTPModelVerify.fromJson(jsonString);
    sp.setString(PREF_TOKEN, mobileData.token!);
    sp.setBool("userStatus", mobileData.status!);
    sp.setString("name", mobileData.name!);
    sp.setString("mPin", mobileData.data!.device!.mpin.toString());

    return responseData;
  }


  /// Bank Details
  static Future postBankDetails(Map<String, dynamic> fieldMap) async {
    var sp = await SharedPreferences.getInstance();
    var id= sp.getString("cardId");
    var url = BASE_URL + "customer/bank/update/$id";
    var responseData;
    await _hitService(
            url,
            HttpMethod.HTTP_POST,
            RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
            TokenType.TYPE_NONE,
            fieldMap)
        .then((value) => {responseData = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      //print("outer: ${error} ${stackTrace}");
      DioError dioError = error;
      print(dioError.message);
      print("outer: ${error} ${stackTrace}");
    });
    var bankData = BankDetailsRes.fromJson(json.decode(json.encoder.convert(responseData)));
    return bankData;
  }

  /// Bank Mandate
  static Future postCustomerMandate(Map<String, dynamic> fieldMap) async {
    var sp = await SharedPreferences.getInstance();
    var id= sp.getString("cardId");
    var url = BASE_URL + "customer/mandate/create/$id";
    var responseData;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {responseData = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      //print("outer: ${error} ${stackTrace}");
      DioError dioError = error;
      print(dioError.message);
      print("outer: ${error} ${stackTrace}");
    });
    // print(responseData.toString());
    // print("responses");
    //
    // var jsonString = responseData;
    // var mobileData = OTPModelVerify.fromJson(jsonString);
    // var sp = await SharedPreferences.getInstance();
    // sp.setString(PREF_TOKEN, mobileData.token!);
    // sp.setBool("userStatus", mobileData.status!);
    // sp.setString("name", mobileData.name!);
    // if (mobileData.data?.device?.mpin != null) {
    //   sp.setString("mPin", mobileData.data!.device!.mpin.toString());
    // } else {
    //   sp.setString("mPin", "");
    // }
    return responseData;
  }

  /// Agreement URL
  static Future postCustomerAgreement(Map<String, dynamic> fieldMap) async {
    var sp = await SharedPreferences.getInstance();
    var id= sp.getString("cardId");
    var url = BASE_URL + "customer/agreement/send/${id}";
    var responseData;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {responseData = value})
        .catchError((error, stackTrace) {
      // error is SecondError
      //print("outer: ${error} ${stackTrace}");
      DioError dioError = error;
      print(dioError.message);
      print("outer: ${error} ${stackTrace}");
    });
    // print(responseData.toString());
    // print("responses");
    //
    // var jsonString = responseData;
    // var mobileData = OTPModelVerify.fromJson(jsonString);
    // var sp = await SharedPreferences.getInstance();
    // sp.setString(PREF_TOKEN, mobileData.token!);
    // sp.setBool("userStatus", mobileData.status!);
    // sp.setString("name", mobileData.name!);
    // if (mobileData.data?.device?.mpin != null) {
    //   sp.setString("mPin", mobileData.data!.device!.mpin.toString());
    // } else {
    //   sp.setString("mPin", "");
    // }
    return responseData;
  }

  /// checkLiveNess API
  static Future<Object> getFaceCheckLiveNessAPIData(
      String changeFaceDetectionBase64,) async {
    var url = 'https://eve.idfy.com/v3/tasks/sync/check_photo_liveness/face';
    print(url);

    BaseOptions options = new BaseOptions(
      baseUrl: url,
      connectTimeout: 20000,
      receiveTimeout: 20000,
    );
    Dio dio = Dio(options);

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['api-key'] = '8586e469-d8ec-4385-bff8-992d2851d101';
    dio.options.headers["account-id"] =
    "86d3de46fffe/a1ba7349-ba70-4984-8d49-a8abbdc394ef";

    Response response = await dio.post(
      url,
      data: {
        "task_id": "74f4c926-250c-43ca-9c53-453e87ceacd1",
        "group_id": "8e16424a-58fc-4ba4-ab20-5bc8e7c3c41e",
        "data": {
          "document1": changeFaceDetectionBase64,
        },
      },
    );

    if (response.statusCode == 200) {
      // print("faceData");
      // print(convert.jsonEncode(response.data));
      var jsonString = response.data;
      LivenessFaceModel liveNessModelData =
      LivenessFaceModel.fromJson(jsonString);
      // print(liveNessModelData.result.isLive);
      // print(liveNessModelData.result.isFaceCropped);
      // print(liveNessModelData.result.reviewRequired);
      return liveNessModelData;
    } else {
      switch (response.statusCode) {
        case 400:
          return WebError.BAD_REQUEST;
        case 403:
          return WebError.BAD_REQUEST;
        case 500:
          return WebError.INTERNAL_SERVER_ERROR;
        case 404:
          return WebError.NOT_FOUND;
        case 401:
          return WebError.UNAUTHORIZED;
        case 409:
          return WebError.ALREADY_EXIST;
        default:
          return WebError.UNKNOWN;
      }
    }
  }

  /// create mPin
  static Future<dynamic> createMPinService(
      Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "customer/mpin/update";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value});
    print(response);
    print("response");
    return response;
  }

  /// send agreement
  static Future<dynamic> sendAgreementService(
      Map<String, dynamic> fieldMap) async {
    var sp = await SharedPreferences.getInstance();
    var id= sp.getString("cardId");
    var url = BASE_URL + "customer/agreement/send/${id}";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value});
    print(response);
    print("response");
    return response;
  }

  /// get Ifsc
  static Future<dynamic> getIfscService(Map<String, dynamic> fieldMap,
      String ifsc) async {
    var url = BASE_URL + "customer/mandate/fetchAuthMode/${ifsc}";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_GET,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value});
    return response;
  }
  /// get T&C
  static Future<dynamic> getTCService(Map<String, dynamic> fieldMap
      ) async {
    var url = BASE_URL + "customer/tnc/fetch";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_GET,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value});
    return response;
  }
  /// get FAQ
  static Future<dynamic> getFaqService(Map<String, dynamic> fieldMap
      ) async {
    var url = BASE_URL + "customer/faq/list";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_GET,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value});
    return response;
  }
  /// customer status
  static Future<dynamic> consumerHomeData(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "customer/status/fetch";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_GET,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE, fieldMap).then((value) => {response = value});
    print(response);
    print("response");
    return response;
  }

  static Future<dynamic> getBillsPresented(Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "customer/getBillPresented";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_GET,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE, fieldMap).then((value) => {response = value});
    print(response);
    print("response");
    return response;
  }

  /// submit offer api
  static Future<dynamic> submitOffer(
      Map<String, dynamic> fieldMap) async {
    var url = BASE_URL + "customer/billStatusUpdate";
    var response;
    await _hitService(
        url,
        HttpMethod.HTTP_POST,
        RequestBodyType.TYPE_XX_URLENCODED_FORMDATA,
        TokenType.TYPE_NONE,
        fieldMap)
        .then((value) => {response = value});
    print(response);
    print("response");
    return response;
  }

  ///this method will actually hit the service based on method(GET,PUT,POST
  static Future<dynamic> _hitService(String url, HttpMethod method,
      RequestBodyType type, TokenType tokenType, Map<String, dynamic> fieldMap,
      {List<File>? files,  Map<String, File>? fileMap}) async {
    if (await Utils.checkInternet()) {
      var response;
      var headerMap = Map<String, String>();
      if (tokenType == TokenType.TYPE_BASIC) {
        var sp = await SharedPreferences.getInstance();
        var token = sp.getString(PREF_TOKEN);
        Log.d("$token");
        // var deviceToken = sp.getString(DEVICE_TOKEN);

        // headerMap['fcm_token'] = deviceToken;
        // headerMap['device_type'] = Platform.isIOS?"ios":"android";
        headerMap["authorization"] = "Bearer ${token ?? ""}";
        //headerMap["authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFhcm9uMDcwMkBtYWlsaW5hdG9yLmNvbSIsInVzZXJfaWQiOiI1IiwiY3JlYXRlZF9ieV9zdWJzY3JpYmVyIjoiMCIsInVzZXJfcm9sZSI6IjI2IiwibmV3X2NyZWF0ZWRfYnkiOm51bGwsImFsbCI6eyJJRCI6IjUiLCJlbWFpbCI6ImFhcm9uMDcwMkBtYWlsaW5hdG9yLmNvbSIsInBhc3N3b3JkIjoiJDJhJDEyJGRrc1ZwamxlUlJad2F6ekpRWHJJMi53YjdLckN0eWZHSDNiUWEubEQwdHZITlYyZDhJM2thIiwidG9rZW4iOiJkYTVkNGI5ZmNhMDU4MDNhYjliZjY3M2IyYTRkMjdlNyIsIklQIjoiOTYuNDEuMTIyLjEwNyIsInVzZXJuYW1lIjoiQWFyb24wNzAyIiwiZmlyc3RfbmFtZSI6IkFhcm9uIiwibGFzdF9uYW1lIjoiU21pdGgiLCJhdmF0YXIiOiI1Y2I1Y2JjNGI0YWJhOGFhM2YxMDY0NWVkODQ3YTFiYy5wbmciLCJqb2luZWQiOiIxNjI1MjcwODE2Iiwiam9pbmVkX2RhdGUiOiI3LTIwMjEiLCJvbmxpbmVfdGltZXN0YW1wIjoiMTYzODUxMzI3NCIsIm9hdXRoX3Byb3ZpZGVyIjoiIiwib2F1dGhfaWQiOiIiLCJvYXV0aF90b2tlbiI6IiIsIm9hdXRoX3NlY3JldCI6IiIsImVtYWlsX25vdGlmaWNhdGlvbiI6IjEiLCJhYm91dG1lIjoiIiwicG9pbnRzIjoiMC4wMCIsInByZW1pdW1fdGltZSI6IjAiLCJ1c2VyX3JvbGUiOiIyNiIsImFzc2lnbmVkX3JvbGUiOiIwIiwic2VuZGVyX2lkIjoiMCIsInVzZXJfdHlwZSI6IjEiLCJzdWJzY3JpcHRpb25faWQiOiIxIiwicHJpY2VfaWQiOm51bGwsInN1YnNjcmlwdGlvbl9zdGF0dXMiOiJhY3RpdmUiLCJwcmVtaXVtX3BsYW5pZCI6IjAiLCJub3RpX2NvdW50IjoiOCIsImVtYWlsX2NvdW50IjoiMTEiLCJhY3RpdmVfcHJvamVjdGlkIjoiMCIsInRpbWVyX2NvdW50IjoiMCIsInRpbWVfcmF0ZSI6IjAuMDAiLCJwYXlwYWxfZW1haWwiOiIiLCJhZGRyZXNzXzEiOiIiLCJhZGRyZXNzXzIiOiIiLCJjaXR5IjoiIiwic3RhdGUiOiIiLCJ6aXBjb2RlIjoiIiwiY291bnRyeSI6IiIsImFjdGl2ZSI6IjEiLCJpc0VtYWlsVmVyaWZpZWQiOiIxIiwiYWN0aXZhdGVfY29kZSI6IiIsInN0cmlwZV9zZWNyZXRfa2V5IjoiIiwic3RyaXBlX3B1Ymxpc2hfa2V5IjoiIiwiY2hlY2tvdXQyX2FjY291bnRubyI6IjAiLCJjaGVja291dDJfc2VjcmV0IjoiIiwiY3JlYXRlZF9ieSI6bnVsbCwicmVxdWVzdGVkX2J5IjoiMCIsIm5ld19jcmVhdGVkX2J5IjpudWxsLCJjcmVhdGVkX2J5X3N1YnNjcmliZXIiOiIwIiwiZXhwaXJlX2RhdGUiOiIyMDIxLTA3LTE3IDEyOjA2OjU2IiwiY29tcGFueUlEIjoiMyIsImNvbXBhbnlfc3RhdHVzIjoiMSIsImNvbXBhbnlfcGhvbmUiOiI1NjIgMTIzLTQ1NjciLCJ0ZXJtIjoiMSIsImlzX2RlbGV0ZSI6IjAiLCJwcmV2aW91c19wbGFuIjpudWxsLCJ0aW1lX3pvbmUiOiJBbWVyaWNhXC9Mb3NfQW5nZWxlcyJ9LCJpYXQiOjE2Mzg1MTM1MTAsImV4cCI6MTYzODYwMDAxMH0.K8ymwJmoKRJCTl0HUzhdbu8IfmvGZT8rMqQho8gTHR8" ?? "";
      } else {
        var sp = await SharedPreferences.getInstance();
        var token = await sp.get(PREF_TOKEN);
        //  var deviceToken = await sp.getString(DEVICE_TOKEN);
        // headerMap['fcm_token'] = deviceToken;
        // headerMap['device_type'] = Platform.isIOS?"ios":"android";

        headerMap["authorization"] = "Bearer ${token ?? ""}";
        //headerMap["authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFhcm9uMDcwMkBtYWlsaW5hdG9yLmNvbSIsInVzZXJfaWQiOiI1IiwiY3JlYXRlZF9ieV9zdWJzY3JpYmVyIjoiMCIsInVzZXJfcm9sZSI6IjI2IiwibmV3X2NyZWF0ZWRfYnkiOm51bGwsImFsbCI6eyJJRCI6IjUiLCJlbWFpbCI6ImFhcm9uMDcwMkBtYWlsaW5hdG9yLmNvbSIsInBhc3N3b3JkIjoiJDJhJDEyJGRrc1ZwamxlUlJad2F6ekpRWHJJMi53YjdLckN0eWZHSDNiUWEubEQwdHZITlYyZDhJM2thIiwidG9rZW4iOiJkYTVkNGI5ZmNhMDU4MDNhYjliZjY3M2IyYTRkMjdlNyIsIklQIjoiOTYuNDEuMTIyLjEwNyIsInVzZXJuYW1lIjoiQWFyb24wNzAyIiwiZmlyc3RfbmFtZSI6IkFhcm9uIiwibGFzdF9uYW1lIjoiU21pdGgiLCJhdmF0YXIiOiI1Y2I1Y2JjNGI0YWJhOGFhM2YxMDY0NWVkODQ3YTFiYy5wbmciLCJqb2luZWQiOiIxNjI1MjcwODE2Iiwiam9pbmVkX2RhdGUiOiI3LTIwMjEiLCJvbmxpbmVfdGltZXN0YW1wIjoiMTYzODUxMzI3NCIsIm9hdXRoX3Byb3ZpZGVyIjoiIiwib2F1dGhfaWQiOiIiLCJvYXV0aF90b2tlbiI6IiIsIm9hdXRoX3NlY3JldCI6IiIsImVtYWlsX25vdGlmaWNhdGlvbiI6IjEiLCJhYm91dG1lIjoiIiwicG9pbnRzIjoiMC4wMCIsInByZW1pdW1fdGltZSI6IjAiLCJ1c2VyX3JvbGUiOiIyNiIsImFzc2lnbmVkX3JvbGUiOiIwIiwic2VuZGVyX2lkIjoiMCIsInVzZXJfdHlwZSI6IjEiLCJzdWJzY3JpcHRpb25faWQiOiIxIiwicHJpY2VfaWQiOm51bGwsInN1YnNjcmlwdGlvbl9zdGF0dXMiOiJhY3RpdmUiLCJwcmVtaXVtX3BsYW5pZCI6IjAiLCJub3RpX2NvdW50IjoiOCIsImVtYWlsX2NvdW50IjoiMTEiLCJhY3RpdmVfcHJvamVjdGlkIjoiMCIsInRpbWVyX2NvdW50IjoiMCIsInRpbWVfcmF0ZSI6IjAuMDAiLCJwYXlwYWxfZW1haWwiOiIiLCJhZGRyZXNzXzEiOiIiLCJhZGRyZXNzXzIiOiIiLCJjaXR5IjoiIiwic3RhdGUiOiIiLCJ6aXBjb2RlIjoiIiwiY291bnRyeSI6IiIsImFjdGl2ZSI6IjEiLCJpc0VtYWlsVmVyaWZpZWQiOiIxIiwiYWN0aXZhdGVfY29kZSI6IiIsInN0cmlwZV9zZWNyZXRfa2V5IjoiIiwic3RyaXBlX3B1Ymxpc2hfa2V5IjoiIiwiY2hlY2tvdXQyX2FjY291bnRubyI6IjAiLCJjaGVja291dDJfc2VjcmV0IjoiIiwiY3JlYXRlZF9ieSI6bnVsbCwicmVxdWVzdGVkX2J5IjoiMCIsIm5ld19jcmVhdGVkX2J5IjpudWxsLCJjcmVhdGVkX2J5X3N1YnNjcmliZXIiOiIwIiwiZXhwaXJlX2RhdGUiOiIyMDIxLTA3LTE3IDEyOjA2OjU2IiwiY29tcGFueUlEIjoiMyIsImNvbXBhbnlfc3RhdHVzIjoiMSIsImNvbXBhbnlfcGhvbmUiOiI1NjIgMTIzLTQ1NjciLCJ0ZXJtIjoiMSIsImlzX2RlbGV0ZSI6IjAiLCJwcmV2aW91c19wbGFuIjpudWxsLCJ0aW1lX3pvbmUiOiJBbWVyaWNhXC9Mb3NfQW5nZWxlcyJ9LCJpYXQiOjE2Mzg1MTM1MTAsImV4cCI6MTYzODYwMDAxMH0.K8ymwJmoKRJCTl0HUzhdbu8IfmvGZT8rMqQho8gTHR8" ?? "";
      }
      switch (method) {
        case HttpMethod.HTTP_GET:
          {
            Log.d("Sending Request:: GET $url headers $headerMap");
            // response = await Http.get(Uri.parse(url), headers: headerMap);
            // response = await Dio().get(url, options: Options(headers: headerMap)).;
            await Dio().get(url, options: Options(headers: headerMap)).then((value) => response = value)
                .catchError((error, stackTrace) {
              print('responsesss');
              DioError errors = error;
              print(errors.response?.statusCode.toString());
              response = errors.response;
              return response;
            });
          }
          break;
        case HttpMethod.HTTP_POST:
          {
            if (type == RequestBodyType.TYPE_XX_URLENCODED_FORMDATA) {
              headerMap["Content-Type"] = "application/x-www-form-urlencoded";
              Log.d("Sending Request:: POST $url body $fieldMap");
              response = await Dio().post(
                url,
                options: Options(
                  headers: headerMap,
                ),
                data: fieldMap,
                // encoding: convert.Utf8Codec()
              );
              print(response);
            }
            else if (type == RequestBodyType.TYPE_MULTIPART) {
              var sp = await SharedPreferences.getInstance();
              var token = sp.getString(PREF_TOKEN);
              Log.d("$token");
              headerMap["Content-Type"] = "multipart/form-data";
              headerMap["authorization"] = "Bearer ${token ?? ""}";
              var formData = FormData();


              for (var file in files!) {
                String fileName = file.path.split('/').last;
                formData.files.addAll([
                  MapEntry("file", await MultipartFile.fromFile(file.path,filename: fileName)),
                ]);
              }
              if(fileMap != null && fileMap.isNotEmpty){
                // current_address_img
                for (var file in fileMap.values) {
                  String fileName = file.path.split('/').last;
                  formData.files.addAll([
                    MapEntry("current_address_img", await MultipartFile.fromFile(file.path,filename: fileName)),
                  ]);
                }

              }

              print('formData');
              print(formData.files.length);
              formData.files.forEach((element) {
                print(element.key);
                print(element.value.filename);
              });

              await Dio()
                  .post(url,
                  options: Options(headers: headerMap), data: formData)
                  .then((value) {
                    response = value;
              })
                  .catchError((error, stackTrace) {
                print('responsesss');
                DioError errors = error;
                print(errors.response?.statusCode.toString());
                response = errors.response;
                return response;
              });
            }
            else {
              await Dio().post(url, options: Options(headers: headerMap), data: fieldMap).then((value) {
                response = value;
              }).onError((error, stackTrace) {
                print(error);
                print(stackTrace);
              }).catchError((onError){
                print(onError);
              });
            }
          }
          break;
      }
      var statusCode = response.statusCode;
      Log.d("Response Code  :: $statusCode");
      Log.d("Response  :: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (type == RequestBodyType.TYPE_MULTIPART) {
          return response.data;
        } else
          print("Response is else :: " + response.data.toString());
        return response.data;
      } else {
        switch (response.statusCode) {
          case 400:
            return WebError.BAD_REQUEST;
          case 401:
            return WebError.BAD_REQUEST;
          case 403:
            return WebError.BAD_REQUEST;
          case 500:
            return WebError.INTERNAL_SERVER_ERROR;
          case 404:
            return WebError.NOT_FOUND;
          case 401:
            return WebError.UNAUTHORIZED;
          case 409:
            return WebError.ALREADY_EXIST;
          default:
            return WebError.UNKNOWN;
        }
      }
    } else {
      return WebError.INTERNAL_SERVER_ERROR;
    }
  }
}
