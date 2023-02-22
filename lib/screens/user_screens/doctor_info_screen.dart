import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/components/time_format.dart';
import 'package:docare/models/appointments.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/push_notification/push_notidication.dart';
import 'package:docare/push_notification/send_push_notification.dart';
import 'package:docare/screens/user_screens/appointment_booked.dart';
import 'package:docare/state_management/appointment_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../state_management/providers_barrel.dart';

DateTime dateTime = DateTime.now();
int? appointmentHour;

class DoctorInfo extends StatefulWidget {
  DoctorInfo({
    super.key,
    required this.imageString,
    required this.uid,
  });

  final String imageString;
  final String uid;

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);

    final ap = Provider.of<AuthProvider>(context, listen: false);

    loadFCM();
    listenFCM();

   // print('USER ID : ${AppointmentProvider.currentUser!.uid}');

    // A list for date
    //List<DateBox> dateBox = [];

    // A list for time

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: StreamBuilder(
        stream:
            firebaseFirestore.collection('doctors').doc(widget.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final item = snapshot.data!;

          return Column(
            children: [
              Stack(
                //clipBehavior: Clip.hardEdge,
                children: [
                  Hero(
                    tag: widget.imageString,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.r),
                          bottomRight: Radius.circular(24.r)),
                      child: Image(
                        height: 310.0.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.imageString),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.0.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: backgroundGrey3.withAlpha(60),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              getImage(
                                folderName: 'icons',
                                fileName: 'arrow-left.svg',
                              ),
                              color: backgroundGrey1,
                              width: 24.w,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12.0.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: backgroundGrey3.withAlpha(60),
                          ),
                          child: GestureDetector(
                            child: SvgPicture.asset(
                              getImage(
                                folderName: 'icons',
                                fileName: 'heart.svg',
                              ),
                              color: backgroundGrey1,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              textLabel(
                  text: item.get('name'),
                  fontSize: 32.sp,
                  color: primaryGreen,
                  fontWeight: FontWeight.w600),
              textLabel(
                text: item.get('speciality'),
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
                letterSpacing: 2.0.w,
              ),
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: Container(
                  height: 115.h,
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
                                  fileName: 'badge-check.svg',
                                ),
                                color: primaryGreen,
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textLabel(
                                    text: 'Experience',
                                    fontSize: 14.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  textLabel(
                                      text: '${item.get('experience')} years',
                                      fontSize: 14.sp,
                                      color: primaryGreen,
                                      fontWeight: FontWeight.w600)
                                ],
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textLabel(
                                    text: 'Working hours',
                                    fontSize: 14.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  textLabel(
                                      text:
                                          '${timeFormat(item.get('openTime'))} - ${timeFormat(item.get('closedTime'))}',
                                      fontSize: 14.sp,
                                      color: primaryGreen,
                                      fontWeight: FontWeight.w600)
                                ],
                              ),
                            ],
                          )
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
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0.w),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                  child: textLabel(text: 'Choose Day'),
                ),
              ),
              // Container(
              //   height: 80.h,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: 20,
              //     itemBuilder: ((context, index) {
              //       return Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              //         child: Container(
              //           width: 80.h,
              //           decoration: BoxDecoration(
              //             color: BackgroundGrey1,
              //             borderRadius: BorderRadius.circular(6.r),
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               textLabel(
              //                 text: 'Fri',
              //                 fontSize: 18.sp,
              //                 color: DarkGrey2,
              //               ),
              //               textLabel(
              //                   text: '18',
              //                   fontSize: 22.sp,
              //                   color: Green,
              //                   fontWeight: FontWeight.w800)
              //             ],
              //           ),
              //         ),
              //       );
              //     }),
              //   ),
              // )
              SizedBox(
                height: 80.h,
                child: DateBox(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                  child: textLabel(text: 'Choose Time'),
                ),
              ),
              SizedBox(
                height: 60.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: DateTimeBox(
                      openTime: item.get('openTime'),
                      closeTime: item.get('closedTime')),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: primaryButton(
                  label: 'Book an appiontment',
                  backgroundColor: primaryGreen,
                  size: Size(double.infinity, 70.h),
                  shadow: 2.0,
                  shadowColor: const Color(0xff17cfb6).withAlpha(60),
                  onPressed: () {
                    if (dateTime.day == DateTime.now().day &&
                        DateTime.now().hour > appointmentHour!) {
                      showSnackBar(context, 'Invalid Time');
                    } else {
                      AppointmentProvider.getToken();
                      print('THE TOKEN : ${widget.uid}');
                      // AppointmentProvider.sendNotification(
                      //     token: AppointmentProvider.deviceToken,
                      //     header: 'Appointment Approved',
                      //     body: 'Your appointment was approved by the doctor');
                      // ap.checkExistingUser().then((value) {
                      //   if (value == true) {
                      //     print(ap.userID);
                      //   }
                      // });

                      final appointments = Appointments(
                        doctorName: item.get('name'),
                        doctorProfilePic: item.get('profilePic'),
                        speciality: item.get('speciality'),
                        experience: item.get('experience') + ' years',
                        location: item.get('location'),
                        patientName: ap.userModel.name,
                        patienNumber: ap.userModel.phoneNumber,
                        patientProfilePicl: ap.userModel.profilePic,
                        appointmentDate: dateTime.toString(),
                        appointmentHour: appointmentHour!,
                        isApproved: false,
                        doctorID: widget.uid,
                        patientID: AppointmentProvider.currentUser!.uid,
                        deviceToken: AppointmentProvider.deviceToken,
                        doctorDocumentID:
                            AppointmentProvider.appointmentDocumentID,
                        patientDocumentID:
                            AppointmentProvider.appointmentDocumentID,
                      );

                      appointmentProvider
                          .checkAppointmentExisting()
                          .then((value) {
                        if (!value) {
                          appointmentProvider.saveAppointmentDataToFirebase(
                              context: context,
                              appointments: appointments,
                              doctorID: widget.uid,
                              userID: AppointmentProvider.currentUser!.uid,
                              onSuccess: () {
                                AppointmentProvider.sendPushMessage(
                                  'You have a new appointment request',
                                  'New Appointment',
                                  item.get('deviceToken'),
                                );
                                if (item.data()!.isNotEmpty &&
                                    appointmentHour != null) {
                                  appointmentProvider
                                      .saveAppointmentDataToSP()
                                      .then((value) {
                                    getPageRemoveUntil(
                                      context,
                                      const AppointmentBooked(),
                                    );
                                  });
                                } else {
                                  showSnackBar(context,
                                      'Something went wrong, please try again.');
                                }
                              });
                        } else if (value) {
                          showSnackBar(context,
                              'Something went wrong, please try again.');
                        }
                      });
                    }
                  },
                ),
              )
            ],
          );
        },
      ))),
    );
  }
}

class DateBox extends StatefulWidget {
  DateBox({
    super.key,
  });

  @override
  State<DateBox> createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  // final DateTime dateTime;
  num activeDateBox = 2;

  String monthName() {
    String name = '';

    for (int i = 0; i < 3; i++) {
      name += DateFormat('MMMM').format(DateTime(0, dateTime.month))[i];
    }

    return name;
  }

  // List<String> getWeekDayName() {
  //   List<String> day = [];

  //   for (int i = 0; i < 6; i++) {
  //     for (int j = 0; j < 3; j++) {
  //       day.add(DateFormat('EEEE').format(dateBox[i].day.)[j]);
  //     }
  //   }

  //   return day;
  // }

  List<DateTime> dateBox = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now().subtract(const Duration(days: 1));
    for (int i = 0; i < 6; i++) {
      dateTime = dateTime.add(const Duration(days: 1));
      dateBox.add(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scroller =
        Provider.of<DoctorScreenInfoProvider>(context, listen: false);

    //print(dateBox);

    // Formatting current dateTime
    DateFormat('yyyy-MM-dd').format(dateTime);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: ListView.builder(
        itemCount: dateBox.length,
        scrollDirection: Axis.horizontal,
        controller: scroller.dateCardScrollController,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              activeDateBox = index;
              dateTime = dateBox[index];
              print(dateTime);
              scroller.goToDateCard(index);
              setState(() {});
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Container(
                width: 85.h,
                decoration: BoxDecoration(
                  color:
                      index == activeDateBox ? primaryGreen : backgroundGrey1,
                  gradient: LinearGradient(
                      colors: index == activeDateBox
                          ? [primaryGreen, const Color(0xff17cfb6)]
                          : [
                              Theme.of(context).colorScheme.primaryContainer,
                              Theme.of(context).colorScheme.primaryContainer
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textLabel(
                      text: monthName(),
                      fontSize: 14.sp,
                      color:
                          index == activeDateBox ? backgroundGrey1 : darkGrey2,
                    ),
                    textLabel(
                      text: dateBox[index].day.toString(),
                      fontSize: 22.sp,
                      color: index == activeDateBox
                          ? backgroundGrey1
                          : primaryGreen,
                      fontWeight: FontWeight.w800,
                    ),
                    textLabel(
                      text: DateFormat('EEEE')
                          .format(dateBox[index])
                          .toString()
                          .substring(0, 3),
                      fontSize: 14.sp,
                      color:
                          index == activeDateBox ? backgroundGrey1 : darkGrey2,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DateTimeBox extends StatelessWidget {
  DateTimeBox(
      {super.key,
      // required this.hour,
      // required this.isActive,
      required this.openTime,
      required this.closeTime});

  // final int hour;
  // final bool isActive;
  final int openTime;
  final num closeTime;
  bool isActive = false;

  List<int> dateTimeBox = [];

  // String monthName() {
  //   String name = '';

  //   for (int i = 0; i < 3; i++) {
  //     name += DateFormat('MMMM').format(DateTime(0, dateTime.month))[i];
  //   }

  //   return name;
  // }

  // String getWeekDayName() {
  //   String day = ' ';

  //   for (int i = 0; i < 3; i++) {
  //     day += DateFormat('EEEE').format(dateTime)[i];
  //   }

  //   return day;
  // }

  @override
  Widget build(BuildContext context) {
    appointmentHour = openTime;
    num activeTimeBox = openTime;

    final scroller =
        Provider.of<DoctorScreenInfoProvider>(context, listen: false);

    for (int i = openTime; i <= closeTime; i++) {
      // Adding date to the dateBox List

      // debugPrint('I $i');

      dateTimeBox.add(i);

      // print('OUTER : $activeTimeBox');

      // Increasing date day by one

      //final ap = Provider.of<AuthProvider>(context, listen: false);
    }

    return StatefulBuilder(
      builder: (context, setState) => ListView(
        controller: scroller.timeCardScrollController,
        //itemCount: dateTimeBox.length,
        scrollDirection: Axis.horizontal,
        children: List.generate(
            dateTimeBox.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTimeBox = index + openTime;
                        isActive = !isActive;
                        appointmentHour = index + openTime;
                        scroller.goToTimeCard(index);
                      });
                    },
                    child: Container(
                      width: 85.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: index ==
                                  dateTimeBox.indexOf(activeTimeBox as int)
                              ? [primaryGreen, const Color(0xff17cfb6)]
                              : [
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  Theme.of(context).colorScheme.primaryContainer
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textLabel(
                            text: timeFormat(dateTimeBox[index]),
                            fontSize: 18.sp,
                            color: index ==
                                    dateTimeBox.indexOf(activeTimeBox as int)
                                ? backgroundGrey1
                                : darkGrey2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }

  // Widget card(BuildContext context, bool isActive, int hour) {
  //   return
  // }
}
