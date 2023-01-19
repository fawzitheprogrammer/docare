import 'package:docare/components/components_barrel.dart';
import 'package:docare/components/text.dart';
import 'package:docare/public_packages.dart';
import 'package:intl/intl.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({super.key, required this.imageString});

  final String imageString;

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  int activeDateBox = 2;
  int activeTimeBox = 9;

  @override
  Widget build(BuildContext context) {
    // A list for date
    List<DateBox> dateBox = [];

    // A list for time
    List<DateTimeBox> dateTimeBox = [];

    // Creating a dateTime object to get current date
    DateTime dateTime = DateTime.now();

    // Formatting current dateTime
    DateFormat('yyyy-MM-dd').format(dateTime);

    // Looping and increasing current date day by one on each loop
    for (int i = 0; i < 6; i++) {
      // Adding date to the dateBox List
      dateBox.add(DateBox(
        dateTime: dateTime,
        isActive: i == activeDateBox,
      ));

      // Increasing date day by one
      dateTime = dateTime.add(const Duration(days: 1));
    }

    for (int i = 9; i < 22; i++) {
      // Adding date to the dateBox List
      dateTimeBox.add(DateTimeBox(
        hour: i,
        isActive: i == activeTimeBox,
      ));

      // Increasing date day by one
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
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
                      image: AssetImage(widget.imageString),
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
                          color: BackgroundGrey3.withAlpha(60),
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
                            color: BackgroundGrey1,
                            width: 24.w,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12.0.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: BackgroundGrey3.withAlpha(60),
                        ),
                        child: GestureDetector(
                          child: SvgPicture.asset(
                            getImage(
                              folderName: 'icons',
                              fileName: 'heart.svg',
                            ),
                            color: BackgroundGrey1,
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
                text: 'Naza Qadir',
                fontSize: 32.sp,
                color: Green,
                fontWeight: FontWeight.w600),
            textLabel(
              text: 'Cardiologist',
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
                                fileName: 'badge-check.svg',
                              ),
                              color: Green,
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
                                    text: '7 Years',
                                    fontSize: 14.sp,
                                    color: Green,
                                    fontWeight: FontWeight.w600)
                              ],
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
                                    text: '9 AM - 9 PM',
                                    fontSize: 14.sp,
                                    color: Green,
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
                      color: Green.withAlpha(40),
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
                              color: Green,
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Flexible(
                              child: textLabel(
                                text: 'Top Med Center, 40 m street',
                                fontSize: 12.sp,
                                color: Green,
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: ListView.builder(
                  itemCount: dateBox.length,
                  scrollDirection: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        activeDateBox = index;
                        setState(() {});
                      },
                      child: dateBox[index],
                    );
                  }),
                ),
              ),
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
                child: ListView.builder(
                  itemCount: dateTimeBox.length,
                  scrollDirection: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        activeTimeBox = index + 9;
                        setState(() {});
                      },
                      child: dateTimeBox[index],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: primaryButton(
                label: 'Book an appiontment',
                backgroundColor: Green,
                size: Size(double.infinity, 70.h),
                shadow: 2.0,
                shadowColor: Color(0xfff17cfb6).withAlpha(60),
                onPressed: () {},
              ),
            )
          ],
        ),
      )),
    );
  }

  // Widget buildDateBox() {
  //   return
  // }
}

class DateBox extends StatelessWidget {
  const DateBox({super.key, required this.dateTime, required this.isActive});

  final DateTime dateTime;
  final bool isActive;

  String monthName() {
    String name = '';

    for (int i = 0; i < 3; i++) {
      name += DateFormat('MMMM').format(DateTime(0, dateTime.month))[i];
    }

    return name;
  }

  String getWeekDayName() {
    String day = ' ';

    for (int i = 0; i < 3; i++) {
      day += DateFormat('EEEE').format(dateTime)[i];
    }

    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Container(
        width: 85.h,
        decoration: BoxDecoration(
          color: isActive ? Green : BackgroundGrey1,
          gradient: LinearGradient(
              colors: isActive
                  ? [Green, const Color(0xfff17cfb6)]
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
              color: isActive ? BackgroundGrey1 : DarkGrey2,
            ),
            textLabel(
              text: dateTime.day.toString(),
              fontSize: 22.sp,
              color: isActive ? BackgroundGrey1 : Green,
              fontWeight: FontWeight.w800,
            ),
            textLabel(
              text: getWeekDayName(),
              fontSize: 14.sp,
              color: isActive ? BackgroundGrey1 : DarkGrey2,
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeBox extends StatelessWidget {
  const DateTimeBox({super.key, required this.hour, required this.isActive});

  final int hour;
  final bool isActive;

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w),
      child: Container(
        width: 85.w,
        height: 60.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isActive
                  ? [Green, const Color(0xfff17cfb6)]
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
              text: '$hour:00',
              fontSize: 18.sp,
              color: isActive ? BackgroundGrey1 : DarkGrey2,
            ),
          ],
        ),
      ),
    );
  }
}
