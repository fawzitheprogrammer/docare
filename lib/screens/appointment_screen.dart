import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';
import 'package:intl/intl.dart';

import '../components/text.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(12.w),
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
                            child: Image.asset(
                              'assets/doc.jpg',
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
                                'Name : Naza Qadir',
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.w600
                                    //fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                'Specialty : Cardiologist',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  //fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Experience : 7 years',
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
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: Container(
                        height: 80.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: Green40Percent.withAlpha(40)),
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
                                      color: Green,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    textLabel(
                                      text: DateFormat('yyyy-MM-dd')
                                          .format(
                                            DateTime.now(),
                                          )
                                          .toString(),
                                      fontSize: 14.sp,
                                      color: Green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textLabel(
                                      text: ',Wed',
                                      fontSize: 14.sp,
                                      color: Green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30.h,
                                  width: 1.5.h,
                                  color: Green.withAlpha(40),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      getImage(
                                        folderName: 'icons',
                                        fileName: 'clock-five.svg',
                                      ),
                                      color: Green,
                                    ),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    textLabel(
                                        text: '9 AM - 9 PM',
                                        fontSize: 14.sp,
                                        color: Green,
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
                              label: 'Reschedule',
                              backgroundColor: Green,
                              size: Size(0, 70.h),
                              shadow: 2.0,
                              shadowColor: Color(0xfff17cfb6).withAlpha(60),
                              onPressed: () {},
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
                              onPressed: () {},
                              borderColor: Green.withAlpha(40),
                              borderWidth: 2,
                              textColor: Green,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
