

// void sendNotification(
//     {required String token,
//     required String header,
//     required String body}) async {
//   String serverKey =
//       'AAAA30IK5OU:APA91bH-azU7aSjq7xR78IgylCzfP8Xejt0Y9rn_Ykc3AcgGBdPAx-wL-gt1ORTFdn-3MuToY6S_s_Pp925X45J96LBHwwFFve-2EF_hQv0G38HgcrCN1lIwwk6JGFcZF3y6QYtvbCM8';
//   try {
//     print('called');
//     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'key=$serverKey',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'status': 'done',
//             'title': header,
//             'body': body,
//           },
//           'notification': <String, dynamic>{
//             'title': header,
//             'body': body,
//             'android_channel_id': 'docare'
//           },
//           'to': token
//         }));
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }
