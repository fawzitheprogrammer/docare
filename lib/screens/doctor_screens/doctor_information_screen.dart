import 'dart:io';

import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/state_management/appointment_provider.dart';
import '../../main.dart';
import '../../models/doctor_model.dart';
import '../../models/user_model.dart';
import '../../shared_preferences/shared_pref_barrel.dart';
import '../../state_management/providers_barrel.dart';
import '../user_screens/home_screen.dart';

class DoctorInfromationScreen extends StatefulWidget {
  const DoctorInfromationScreen({super.key});

  @override
  State<DoctorInfromationScreen> createState() =>
      _DoctorInfromationScreenState();
}

class _DoctorInfromationScreenState extends State<DoctorInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  //final specialityController = TextEditingController();
  final experienceController = TextEditingController();
  final locationController = TextEditingController();

  TimeOfDay? _openTime;
  TimeOfDay? _closedTime;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    //specialityController.dispose();
    experienceController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  List<String> categoryLabels = [
    'Cardiologist',
    'Dentist',
    'Dermatologis',
    'Gastroenterologis',
    'Histologist',
    'Histopathology',
    'Nephrologist',
    'Ophthalmologists',
    'Orthopedic'
  ];

  String speciality = '';

  String iconString = '';

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryGreen,
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 5.0),
                  child: Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => selectImage(),
                          child: image == null
                              ? CircleAvatar(
                                  backgroundColor: primaryGreen,
                                  radius: 50,
                                  child: const Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: 50,
                                ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // name field
                              textFeld(
                                hintText: "Your name",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                              ),

                              textFeld(
                                hintText: "Years of experience",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: experienceController,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.r),
                                        topRight: Radius.circular(8.r),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) => SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: ListView(
                                          children: List.generate(
                                            categoryLabels.length,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                speciality =
                                                    categoryLabels[index];

                                                iconString = category[index];
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(4.0.w),
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.all(4.0.w),
                                                  height: 60.h,
                                                  decoration: BoxDecoration(
                                                    color: primaryGreen
                                                        .withAlpha(10),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        getImage(
                                                          folderName:
                                                              'category',
                                                          fileName:
                                                              category[index],
                                                        ),
                                                        height: 40.h,
                                                        color: primaryGreen,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      textLabel(
                                                        text: categoryLabels[
                                                            index],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 60.h,
                                  //width: 30.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: primaryGreen.shade50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 4.w),
                                      iconString.isNotEmpty
                                          ? SvgPicture.asset(
                                              getImage(
                                                  folderName: 'category',
                                                  fileName: iconString),
                                              height: 40.h,
                                              color: primaryGreen,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(),
                                      SizedBox(width: 2.w),
                                      textLabel(
                                          text: speciality.isEmpty
                                              ? 'Specialty'
                                              : speciality,
                                          // color: primaryGreen,
                                          color: primaryGreen.shade600,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              textFeld(
                                hintText: "Location",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: locationController,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildTimeCard(
                                      onTap: () async {
                                        _openTime =
                                            await _showTimePicker(context);

                                        setState(() {});
                                      },
                                      label: 'Open time',
                                      timeOfDay: _openTime,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  textLabel(text: 'To'),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Expanded(
                                    child: buildTimeCard(
                                      onTap: () async {
                                        _closedTime =
                                            await _showTimePicker(context);

                                        setState(() {});
                                      },
                                      label: 'Close time',
                                      timeOfDay: _closedTime,
                                    ),
                                  ),
                                ],
                              ),

                              // // email
                              // textFeld(
                              //   hintText: "abc@example.com",
                              //   icon: Icons.email,
                              //   inputType: TextInputType.emailAddress,
                              //   maxLines: 1,
                              //   controller: emailController,
                              // ),

                              // // bio
                              // textFeld(
                              //   hintText: "Enter your bio here...",
                              //   icon: Icons.edit,
                              //   inputType: TextInputType.name,
                              //   maxLines: 2,
                              //   controller: bioController,
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          // height: 50,
                          // width: MediaQuery.of(context).size.width * 0.90,
                          child: primaryButton(
                            label: 'Register',
                            backgroundColor: primaryGreen,
                            size: Size(
                                MediaQuery.of(context).size.width * 0.90, 70.h),
                            onPressed: () {
                              // print(_openTime!.format(context));

                              if (_openTime != null && _closedTime != null) {
                                if (_closedTime!.hour - _openTime!.hour > 1) {
                                  storeData(appointmentProvider);
                                } else {
                                  showSnackBar(
                                    bgColor: Colors.redAccent,
                                    content:
                                        'Working hours can\'t be that short!',
                                    context: context,
                                    textColor: Colors.white,
                                  );
                                }
                              } else {
                                showSnackBar(
                                  bgColor: Colors.redAccent,
                                  content:
                                      "Please fill all fields correctly and try again.",
                                  context: context,
                                  textColor: Colors.white,
                                );
                              }
                              //setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildTimeCard(
      {void Function()? onTap, TimeOfDay? timeOfDay, String? label}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 30.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: primaryGreen.shade50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                getImage(
                  folderName: 'icons',
                  fileName: 'clock-five.svg',
                ),
                color: primaryGreen,
                width: 20,
              ),
              SizedBox(width: 8.w),
              textLabel(
                text: timeOfDay == null ? label! : timeOfDay.format(context),
                color: primaryGreen,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: primaryGreen,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          // prefixIcon: Container(
          //   margin: const EdgeInsets.all(8.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     color: Green,
          //   ),
          //   child: Icon(
          //     icon,
          //     size: 20,
          //     color: Colors.white,
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: primaryGreen.shade50,
          filled: true,
          hintStyle: GoogleFonts.poppins(
            color: primaryGreen.shade600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay> _showTimePicker(BuildContext context) async {
    TimeOfDay initialTime = const TimeOfDay(hour: 9, minute: 0);

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    return selectedTime!;
  }

  // store user data to database
  void storeData(AppointmentProvider appointment) async {
    appointment.getToken().then((value) {
      final ap = Provider.of<AuthProvider>(context, listen: false);
      // AppointmentProvider.getToken();

      DoctorModel doctorModel = DoctorModel(
        name: nameController.text.trim(),
        profilePic: "",
        createdAt: "",
        phoneNumber: "",
        uid: "",
        speciality: speciality,
        location: locationController.text.trim(),
        experience: experienceController.text.trim(),
        openTime: _openTime!.hour,
        closedTime: _closedTime!.hour,
        isApproved: false,
        deviceToken: value,
        isFav: false,
      );
      if (image != null &&
          nameController.text.isNotEmpty &&
          locationController.text.isNotEmpty &&
          experienceController.text.isNotEmpty &&
          _openTime != null &&
          _closedTime != null) {
        ap.saveDoctorDataToFirebase(
          context: context,
          doctorModel: doctorModel,
          profilePic: image!,
          onSuccess: () {
            ap.saveDoctorDataToSP().then(
                  (value) => ap.setSignIn().then((value) {
                    ScreenStateManager.setPageOrderID(3);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllScreens(),
                      ),
                      (route) => false,
                    );
                  }),
                );
          },
        );
      } else {
        showSnackBar(
          bgColor: Colors.redAccent,
          content: "Please fill all fields correctly and try again.",
          context: context,
          textColor: Colors.white,
        );
      }
    });
  }
}
