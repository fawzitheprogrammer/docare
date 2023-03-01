import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/push_notification/push_notidication.dart';
import 'package:docare/state_management/appointment_provider.dart';
import 'package:docare/state_management/providers_barrel.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAppointmentList(context),
    );
  }

  Widget buildAppointmentList(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final ap = Provider.of<AuthProvider>(context, listen: false);

    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    //requestPermission();
    loadFCM();
    listenFCM();

    //debugPrint(AppointmentProvider.currentUser!.uid);

    return StreamBuilder(
      stream: firestore
          .collection('doctors')
          .doc(AppointmentProvider.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final item = snapshot.data;
          if (item!.get('deviceToken') == "") {
            AppointmentProvider.getToken();
            firestore
                .collection('doctors')
                .doc(
                  AppointmentProvider.currentUser!.uid,
                )
                .update({'deviceToken': AppointmentProvider.deviceToken}).then(
                    (value) {});
          }
        }

        bool isDoctorApproved = snapshot.data!.get('isApproved');

        //print(data);

        return StreamBuilder(
          stream: firestore
              .collection('doctors')
              .doc(ap.firebaseAuth.currentUser!.uid)
              .collection('appointments')
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryGreen,
                ),
              );
            }
            final item = snapshot.data!.docs;

            // bool? isApproved;
            //ap.isDoctorApproved().then((value) => print(value));

            ap.isDoctorApproved();

            //print(isApproved.toString());

            List<Widget> appointmentList = [];

            for (var i in item) {
              final fetchedData = i.data();

              //final bool fecthedData = itemData['isApproved'];

              final appointmentCard = Padding(
                padding: EdgeInsets.all(12.0.w),
                child: Container(
                  height: 350.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            margin: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: Image.network(
                                fetchedData['patientProfilePicl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${fetchedData['patientName']}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.w600
                                      //fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  'Phone s: ${fetchedData['patienNumber'].toString().substring(4)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Text(
                                //   'Experience :  ${fetchedData['experience']}',
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 14.sp,
                                //     color:
                                //         Theme.of(context).colorScheme.onPrimary,
                                //     //fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              SvgPicture.asset(
                                getImage(
                                  folderName: 'icons',
                                  fileName: !fetchedData['isApproved']
                                      ? 'pending.svg'
                                      : 'check.svg',
                                ),
                                color: !fetchedData['isApproved']
                                    ? Colors.orange
                                    : Colors.green,
                                width: 24.w,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              textLabel(
                                text: !fetchedData['isApproved']
                                    ? 'Pending'
                                    : 'Approved',
                                fontSize: 10.sp,
                                color: !fetchedData['isApproved']
                                    ? Colors.orange
                                    : Colors.green,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0.w),
                        child: Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: primaryGreen40Percent.withAlpha(40)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        getImage(
                                          folderName: 'icons',
                                          fileName: 'calendar_filled.svg',
                                        ),
                                        color: primaryGreen,
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      textLabel(
                                        text: DateFormat('yyyy-MM-dd')
                                            .format(
                                              DateTime.parse(
                                                fetchedData['appointmentDate'],
                                              ),
                                            )
                                            .toString(),
                                        fontSize: 14.sp,
                                        color: primaryGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textLabel(
                                        text:
                                            ',${DateFormat('EEEE').format(DateTime.parse(fetchedData['appointmentDate'])).substring(0, 3)}',
                                        fontSize: 14.sp,
                                        color: primaryGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30.h,
                                    width: 1.5.h,
                                    color: primaryGreen.withAlpha(40),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        getImage(
                                          folderName: 'icons',
                                          fileName: 'clock-five.svg',
                                        ),
                                        color: primaryGreen,
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      textLabel(
                                          text: DateFormat('h:mm a')
                                              .format(
                                                DateTime.tryParse(
                                                  DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month,
                                                    DateTime.now().day,
                                                    fetchedData[
                                                        'appointmentHour'],
                                                  ).toString(),
                                                )!,
                                              )
                                              .toString(),
                                          fontSize: 14.sp,
                                          color: primaryGreen,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: Row(
                          children: [
                            !fetchedData['isApproved']
                                ? Expanded(
                                    child: primaryButton(
                                      label: 'Accept',
                                      backgroundColor: primaryGreen,
                                      size: Size(0, 70.h),
                                      shadow: 2.0,
                                      shadowColor:
                                          const Color(0xff17cfb6).withAlpha(60),
                                      onPressed: () async {
                                        AppointmentProvider.getToken();
                                        print(fetchedData['patientDocumentID']);

                                        updateDocuemnt(
                                          firestore: firestore,
                                          parentCollection: 'users',
                                          userDocumentID:
                                              fetchedData['patientID'],
                                          appointMentID:
                                              fetchedData['patientDocumentID'],
                                        ).then((value) {
                                          updateDocuemnt(
                                            firestore: firestore,
                                            parentCollection: 'doctors',
                                            userDocumentID:
                                                fetchedData['doctorID'],
                                            appointMentID:
                                                fetchedData['doctorDocumentID'],
                                          ).then((value) {
                                            AppointmentProvider.sendPushMessage(
                                              '${fetchedData['doctorName']} accepted your appointment',
                                              'Appointment Accepted',
                                              fetchedData['deviceToken'],
                                            );
                                          });
                                        });

                                        // AppointmentProvider.isSave = false;
                                        // final appointments = Appointments(
                                        //   doctorName: fetchedData['doctorName'],
                                        //   doctorProfilePic:
                                        //       fetchedData['doctorProfilePic'],
                                        //   speciality: fetchedData['speciality'],
                                        //   experience:
                                        //       fetchedData['experience'] + ' years',
                                        //   location: fetchedData['location'],
                                        //   patientName: fetchedData['patientName'],
                                        //   patienNumber: fetchedData['patienNumber'],
                                        //   patientProfilePicl:
                                        //       fetchedData['patientProfilePicl'],
                                        //   appointmentDate:
                                        //       fetchedData['appointmentDate'],
                                        //   appointmentHour:
                                        //       fetchedData['appointmentHour'],
                                        //   isApproved: true,
                                        //   doctorID: fetchedData['doctorID'],
                                        //   patientID: fetchedData['patientID'],
                                        //   deviceToken: fetchedData['deviceToken'],
                                        //   doctorDocumentID:
                                        //       fetchedData['doctorDocumentID'],
                                        //   patientDocumentID:
                                        //       fetchedData['patientDocumentID'],
                                        // );

                                        // firestore
                                        //     .collection('users')
                                        //     .doc(
                                        //       fetchedData['patientID'],
                                        //     )
                                        //     .collection('appointments')
                                        //     .doc(fetchedData['patientDocumentID'])
                                        //     .update(appointments.toMap())
                                        //     .then((value) {
                                        //   AppointmentProvider.sendPushMessage(
                                        //     '${fetchedData['doctorName']} accepted your appointment',
                                        //     'Appointment Accepted',
                                        //     fetchedData['deviceToken'],
                                        //   );
                                        // });

                                        // appointmentProvider
                                        //     .checkAppointmentExisting()
                                        //     .then((value) {
                                        //   appointmentProvider
                                        //       .saveAppointmentDataToFirebase(
                                        //           context: context,
                                        //           appointments: appointments,
                                        //           doctorID: fetchedData['doctorID'],
                                        //           userID: fetchedData['patientID'],
                                        //           onSuccess: () {
                                        //             AppointmentProvider
                                        //                 .sendPushMessage(
                                        //               'You have a new appointment request',
                                        //               'New Appointment',
                                        //               fetchedData['deviceToken'],
                                        //             );
                                        //             if (fetchedData!.isNotEmpty &&
                                        //                 appointmentHour != null) {
                                        //               appointmentProvider
                                        //                   .saveAppointmentDataToSP()
                                        //                   .then((value) {
                                        //                 AppointmentProvider
                                        //                     .sendPushMessage(
                                        //                   '${fetchedData['doctorName']} accepted your appointment',
                                        //                   'Appointment Accepted',
                                        //                   fetchedData['deviceToken'],
                                        //                 );
                                        //               });
                                        //             } else {
                                        //               showSnackBar(context,
                                        //                   'Something went wrong, please try again.');
                                        //             }
                                        //           });
                                        // });
                                        // AppointmentProvider.appointmentDocumentID =
                                        //     item.id;
                                        //AppointmentProvider.getToken();

                                        // final CollectionReference
                                        //     collectionReference =
                                        //     _firestore.collection("users");
                                        // collectionReference
                                        //     .doc(fetchedData['patientID'])
                                        //     .collection('appointments')
                                        //     .doc(fetchedData['patientDocumentID'])
                                        //     .update({
                                        //   "isApproved": true
                                        // }).whenComplete(() async {
                                        // AppointmentProvider.sendPushMessage(
                                        //   '${fetchedData['doctorName']} accepted your appointment',
                                        //   'Appointment Accepted',
                                        //   fetchedData['deviceToken'],
                                        // );
                                        // }).catchError((e) => print(e));

                                        // _firestore
                                        //     .collection("users")
                                        //     .doc(fetchedData['userID'])
                                        //     .collection('appointments')
                                        //     .doc(fetchedData['patientDocumentID'])
                                        //     .update({
                                        //   "isApproved": true
                                        // }).whenComplete(() async {

                                        // }).catchError((e) => print(e));

                                        // getPage(
                                        //     context,
                                        //     DoctorInfo(
                                        //       imageString:
                                        //           fetchedData['doctorProfilePic'],
                                        //       uid: fetchedData['adminID'],
                                        //     ));
                                      },
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: primaryButton(
                                label: 'Cancel',
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                size: Size(0, 70.h),
                                //shadow: 2.0,
                                //shadowColor: Color(0xfff17cfb6).withAlpha(60),
                                onPressed: () {
                                  appointmentProvider.deleteAppointment(
                                    fetchedData['patientDocumentID'],
                                    fetchedData['doctorID'],
                                    fetchedData['patientID'],
                                  );
                                },
                                borderColor: primaryGreen.withAlpha(40),
                                borderWidth: 2,
                                textColor: primaryGreen,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );

              appointmentList.add(appointmentCard);
            }

            print(ap.firebaseAuth.currentUser!.uid);

            if (!isDoctorApproved) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        getImage(
                            folderName: 'vectors', fileName: 'waiting.svg'),
                        width: 310.w,
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      textLabel(
                        text: 'Your information is under reviewing!',
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16.sp,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      textLabel(
                        text:
                            'Unfortunately you will not be able to recieve any appointments from patients until we are done reviwing your information.\n thanks for you patience.',
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(100),
                        textAlign: TextAlign.center,
                        fontSize: 12.sp,
                      )
                    ],
                  ),
                ),
              );
            } else if (isDoctorApproved && snapshot.data!.docs.isNotEmpty) {
              return ListView(
                children: appointmentList,
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          getImage(
                            folderName: 'vectors',
                            fileName: 'calendar.svg',
                          ),
                          width: 200.h,
                        ),
                        SizedBox(
                          width: 24.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    textLabel(
                        text: 'You have no appointments yet.',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp),
                    textLabel(
                      text: 'All your appointment appear in this screen.',
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withAlpha(120),
                    ),
                  ],
                ),
              );
            }
          }),
        );
      },
    );
  }

  Future<void> updateDocuemnt(
      {required FirebaseFirestore firestore,
      required String parentCollection,
      required String userDocumentID,
      required String appointMentID}) {
    final documentReference = firestore
        .collection(parentCollection)
        .doc(userDocumentID)
        .collection('appointments')
        .doc(appointMentID);

    return documentReference.update({'isApproved': true});
  }
}
