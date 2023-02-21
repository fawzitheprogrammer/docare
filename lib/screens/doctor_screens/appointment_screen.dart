import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/push_notification/push_notidication.dart';
import 'package:docare/push_notification/send_push_notification.dart';
import 'package:docare/state_management/appointment_provider.dart';
import 'package:docare/state_management/providers_barrel.dart';
import 'package:intl/intl.dart';

import '../../navigation/navigator.dart';
import '../user_screens/doctor_info_screen.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAppointmentList(context),
    );
  }

  Widget buildAppointmentList(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    requestPermission();
    loadFCM();
    listenFCM();

    return StreamBuilder(
      stream: _firestore
          .collection('doctors')
          .doc(AppointmentProvider.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        bool isDoctorApproved = snapshot.data!.get('isApproved');

        //print(data);

        return StreamBuilder(
          stream: _firestore
              .collection('doctors')
              .doc(AppointmentProvider.currentUser!.uid)
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

            bool? isApproved;
            ap.isDoctorApproved().then((value) => print(value));

            ap.isDoctorApproved();

            //print(isApproved.toString());

            List<Widget> appointmentList = [];

            for (var i in item) {
              final fetchedData = i.data();
              //final bool fecthedData = itemData['isApproved'];

              final appointmentCard = Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Container(
                  height: 300.h,
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
                            height: 80,
                            width: 80,
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
                          Spacer(),
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
                            Expanded(
                              child: primaryButton(
                                label: 'Accept',
                                backgroundColor: primaryGreen,
                                size: Size(0, 70.h),
                                shadow: 2.0,
                                shadowColor:
                                    const Color(0xff17cfb6).withAlpha(60),
                                onPressed: () async {
                                  AppointmentProvider.isSave = false;
                                  // AppointmentProvider.appointmentDocumentID =
                                  //     item.id;
                                  //AppointmentProvider.getToken();

                                      await _firestore
                                      .collection('users')
                                      .doc(fetchedData['patientID'])
                                      .collection('appointments')
                                      .doc(fetchedData['patientDocumentID'])
                                      .update({
                                    'isApproved': true
                                  }).whenComplete(() async {
                                    AppointmentProvider.sendPushMessage(
                                      '${fetchedData['doctorName']} accepted your appointment',
                                      'New Message',
                                      fetchedData['deviceToken'],
                                    );
                                  }).catchError((e) => print(e));

                                  // getPage(
                                  //     context,
                                  //     DoctorInfo(
                                  //       imageString:
                                  //           fetchedData['doctorProfilePic'],
                                  //       uid: fetchedData['adminID'],
                                  //     ));
                                },
                              ),
                            ),
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
                                  // appointmentProvider.deleteAppointment(
                                  //     item.id, item.get('adminID'));
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
                child: textLabel(text: 'No Appointment yet'),
              );
            }
          }),
        );
      },
    );
  }
}
