import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/models/appointments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/snack_bar.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static bool isSave = true;

  static String deviceToken = '';

  static String appointmentDocumentID = '';
  //bool get isSave => _isLoading;

  static User? currentUser = FirebaseAuth.instance.currentUser;
  Appointments? _appointments;
  Appointments get appointments => _appointments!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // String serverKey =
//;

  static void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA30IK5OU:APA91bH-azU7aSjq7xR78IgylCzfP8Xejt0Y9rn_Ykc3AcgGBdPAx-wL-gt1ORTFdn-3MuToY6S_s_Pp925X45J96LBHwwFFve-2EF_hQv0G38HgcrCN1lIwwk6JGFcZF3y6QYtvbCM8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkAppointmentExisting() async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection('doctors')
        .doc(currentUser!.uid)
        .collection('appointments')
        .doc()
        .get();
    if (snapshot.exists) {
      //print("Appointment EXISTS");
      return true;
    } else {
      //print("Appointment NEW");
      return false;
    }
  }

  static void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token!;
    });
  }

  String generateRandomString() {
    var random = Random();
    var letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var numbers = '0123456789';
    var result = '';
    for (var i = 0; i < 20; i++) {
      var charSet = (i % 2 == 0) ? letters : numbers;
      var randomChar = charSet[random.nextInt(charSet.length)];
      result += randomChar;
    }
    return result;
  }

  // Storing user data to firebase
  void saveAppointmentDataToFirebase({
    required BuildContext context,
    required Appointments appointments,
    required doctorID,
    required userID,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      // await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
      //   userModel.profilePic = value;
      //   userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      //   userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      //   userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      // });

      

      _appointments = appointments;

      String ran = generateRandomString();
      appointmentDocumentID = ran;

      // uploading to database
      if (isSave) {
        await _firebaseFirestore
            .collection("doctors")
            .doc(doctorID)
            .collection("appointments")
            .doc(ran)
            .set(appointments.toMap())
            .then((value) async {
          await _firebaseFirestore
              .collection("users")
              .doc(currentUser!.uid)
              .collection("appointments")
              .doc(ran)
              .set(appointments.toMap())
              .then((value) {
            onSuccess();
            _isLoading = false;
            notifyListeners();
          });
          // onSuccess();
          // _isLoading = false;
          // notifyListeners();
        });
      } else if (isSave == false) {
        //print(appointmentDocumentID);
        await _firebaseFirestore
            .collection("doctors")
            .doc(doctorID)
            .collection("appointments")
            .doc(ran)
            .update(appointments.toMap())
            .then((value) async {
          await _firebaseFirestore
              .collection("users")
              .doc(currentUser!.uid)
              .collection("appointments")
              .doc(ran)
              .update(appointments.toMap())
              .then((value) {
            onSuccess();
            _isLoading = false;
            notifyListeners();
          });
          // onSuccess();
          // _isLoading = false;
          // notifyListeners();
        });
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  // STORING DATA LOCALLY
  Future saveAppointmentDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("appointment", jsonEncode(appointments.toMap()));
  }

  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("appointment") ?? '';
    _appointments = Appointments.fromMap(jsonDecode(data));
    notifyListeners();
  }

  // Get Doctor info from firebase
  Future getppointmentDataToFirebase() async {
    await _firebaseFirestore
        .collection("doctors")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('appointments')
        .doc()
        .get()
        .then((DocumentSnapshot snapshot) {
      _appointments = Appointments(
        doctorName: snapshot['doctorName'] ?? '',
        doctorProfilePic: snapshot['profilePic'] ?? '',
        speciality: snapshot['speciality'] ?? '',
        experience: snapshot['experience'] ?? '',
        location: snapshot['location'] ?? '',
        patientName: snapshot['patientName'] ?? '',
        patienNumber: snapshot['patienNumber'] ?? '',
        patientProfilePicl: snapshot['patientProfilePicl'] ?? '',
        appointmentDate: snapshot['openTime'] ?? '',
        appointmentHour: snapshot['closedTime'] ?? '',
        isApproved: snapshot['isApproved'] ?? '',
        doctorID: snapshot['doctorID'],
        patientID: snapshot['patientID'],
        deviceToken: snapshot['deviceToken'],
        doctorDocumentID: snapshot['doctorDocumentID'] ?? '',
        patientDocumentID: snapshot['patientDocumentID'] ?? '',
      );
    });
  }

  Future deleteAppointment(String documentID, String userOrDoctorId) async {
    await _firebaseFirestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('appointments')
        .doc(documentID)
        .delete()
        .then((_) async {
      await _firebaseFirestore
          .collection('doctors')
          .doc(userOrDoctorId)
          .collection('appointments')
          .doc(documentID)
          .delete()
          .then((value) => print('deleted'));
    });
  }

// // Get user info from firebase
//   Future getUserDataFromFirestore() async {
//     await _firebaseFirestore
//         .collection("users")
//         .doc(_firebaseAuth.currentUser!.uid)
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       _uid = snapshot.id;
//     });
//   }
}
