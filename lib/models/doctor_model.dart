class DoctorModel {
  String name;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String speciality;
  String location;
  String experience;
  int openTime;
  int closedTime;
  String uid;
  String deviceToken;
  bool isApproved = false;

  DoctorModel(
      {required this.name,
      required this.profilePic,
      required this.createdAt,
      required this.phoneNumber,
      required this.speciality,
      required this.location,
      required this.experience,
      required this.openTime,
      required this.closedTime,
      required this.uid,
      required this.deviceToken,
      required this.isApproved});

  // from map
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
        name: map['name'] ?? '',
        uid: map['uid'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        createdAt: map['createdAt'] ?? '',
        profilePic: map['profilePic'] ?? '',
        speciality: map['speciality'] ?? '',
        location: map['location'] ?? '',
        experience: map['experience'] ?? '',
        openTime: map['openTime'] ?? '',
        closedTime: map['closedTime'] ?? '',
        deviceToken: map['deviceToken'] ?? '',
        isApproved: map['isApproved'] ?? '');
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "speciality": speciality,
      "location": location,
      "experience": experience,
      "openTime": openTime,
      "closedTime": closedTime,
      "isApproved": isApproved,
      "deviceToken": deviceToken,
    };
  }
}
