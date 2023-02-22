import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/push_notification/push_notidication.dart';
import 'package:docare/screens/user_screens/doctor_info_screen.dart';
import 'package:docare/state_management/appointment_provider.dart';
import 'package:intl/intl.dart';

import '../../components/url_launcher.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //requestPermission();
    loadFCM();
    listenFCM();
    return Scaffold(
      body: buildAppointmentList(context),
    );
  }

  Widget buildAppointmentList(BuildContext context) {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);

    return StreamBuilder(
        stream: firebaseFirestore
            .collection('users')
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

          //var fetchedData;
          List<Widget> appointmentsList = [];
          //int i = 0;
          for (var item in snapshot.data!.docs) {
            //i++;
            final fetchedData = item.data();

            // if (fetchedData['isApproved'] == true) {
            //   showBigTextNotification(
            //     title: 'Appointment Approved',
            //     body: 'Your appointment is approved',
            //     fln: flutterLocalNotificationsPlugin,
            //   );
            // }

            final appointmentCard = Padding(
              padding: EdgeInsets.all(8.0.w),
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
                              fetchedData['doctorProfilePic'],
                              fit: BoxFit.fitHeight,
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
                                '${fetchedData['doctorName']}',
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.w600
                                    //fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                'Specialty : ${fetchedData['speciality']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  //fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Experience :  ${fetchedData['experience']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  //fontWeight: FontWeight.w500,
                                ),
                              ),
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
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: primaryGreen40Percent.withAlpha(40)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                ),
                              ],
                            ),
                            Divider(
                              indent: 10.w,
                              thickness: 1,
                              endIndent: 10.w,
                              color: primaryGreen.withAlpha(40),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrls(
                                    'https://www.google.com/maps/search/${item.get('location').toString().trim()}');
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 6.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      getImage(
                                        folderName: 'icons',
                                        fileName: 'marker.svg',
                                      ),
                                      color: primaryGreen,
                                      width: 15.w,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Flexible(
                                      child: textLabel(
                                        text: item.get('location'),
                                        fontSize: 12.sp,
                                        color: primaryGreen,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
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
                              label: 'Reschedule',
                              backgroundColor: primaryGreen,
                              size: Size(0, 70.h),
                              shadow: 2.0,
                              shadowColor:
                                  const Color(0xff17cfb6).withAlpha(60),
                              onPressed: () {
                                AppointmentProvider.isSave = false;
                                // AppointmentProvider.appointmentDocumentID =
                                //     item.id;

                                AppointmentProvider.appointmentDocumentID =
                                    item.id;

                                getPage(
                                  context,
                                  DoctorInfo(
                                    imageString:
                                        fetchedData['doctorProfilePic'],
                                    uid: fetchedData['doctorID'],
                                  ),
                                );
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
                                // print(item.id);
                                // print(item.get('doctorID'));
                                appointmentProvider.deleteAppointment(
                                    item.id,
                                    item.get('doctorID'),
                                    item.get('patientID'));
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

            appointmentsList.add(appointmentCard);
          }
          //print(fetchedData['doctorName']);

          return appointmentsList.isNotEmpty
              ? ListView(
                  children: appointmentsList,
                )
              : Center(
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
                        text: 'All your bookings appear in this screen.',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(120),
                      ),
                    ],
                  ),
                );
        }));
  }
}
