class Appointments {
  final String doctorName;
  final String speciality;
  final String experience;
  final String doctorProfilePic;
  final String doctorID;
  final String doctorDocumentID;
  final String patientName;
  final String patienNumber;
  final String patientProfilePicl;
  final String patientID;
  final String patientDocumentID;
  final String appointmentDate;
  final int appointmentHour;
  final String location;
  final String deviceToken;
  bool isApproved = false;

  Appointments({
    required this.doctorName,
    required this.speciality,
    required this.experience,
    required this.doctorProfilePic,
    required this.doctorID,
    required this.doctorDocumentID,
    required this.patientName,
    required this.patienNumber,
    required this.patientProfilePicl,
    required this.patientID,
    required this.patientDocumentID,
    required this.appointmentDate,
    required this.appointmentHour,
    required this.location,
    required this.isApproved,
    required this.deviceToken,
  });

  // from map
  factory Appointments.fromMap(Map<String, dynamic> map) {
    return Appointments(
      doctorName: map['doctorName'] ?? '',
      doctorProfilePic: map['profilePic'] ?? '',
      speciality: map['speciality'] ?? '',
      experience: map['experience'] ?? '',
      doctorID: map['doctorID']??'',
      location: map['location'] ?? '',
      patientName: map['patientName'] ?? '',
      patienNumber: map['patienNumber'] ?? '',
      patientProfilePicl: map['patientProfilePicl'] ?? '',
      patientID: map['patientID'] ?? '',
      appointmentDate: map['openTime'] ?? '',
      appointmentHour: map['closedTime'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
      isApproved: map['isApproved'] ?? '',
      doctorDocumentID: map['doctorDocumentID'] ?? '',
      patientDocumentID: map['patientDocumentID'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "doctorName": doctorName,
      "doctorProfilePic": doctorProfilePic,
      "doctorID": doctorID,
      "speciality": speciality,
      "experience": experience,
      "location": location,
      "patientName": patientName,
      "patienNumber": patienNumber,
      "patientProfilePicl": patientProfilePicl,
      "patientID": patientID,
      "appointmentDate": appointmentDate,
      "appointmentHour": appointmentHour,
      "isApproved": isApproved,
      "deviceToken": deviceToken,
      "doctorDocumentID": doctorDocumentID,
      "patientDocumentID": patientDocumentID
    };
  }
}
