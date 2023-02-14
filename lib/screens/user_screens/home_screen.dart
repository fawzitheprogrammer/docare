import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/user_screens/doctor_info_screen.dart';
import '../../components/components_barrel.dart';
import '../../state_management/providers_barrel.dart';

List<String> category = [
  'cardiologists.svg',
  'dentist.svg',
  'dermatologist.svg',
  'gastroenterologist.svg',
  'histologist.svg',
  'histopathology.svg',
  'nephrologist.svg',
  'ophthalmologists.svg',
  'orthopedic.svg'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: CustomScrollView(
            primary: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome! 🖐',
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                              //fontWeight: FontWeight.w500,
                            ),
                          ),
                          FutureBuilder(
                            future: ap.getUserDataFromFirestore(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else {
                                return Text(
                                  ap.userModel.name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 28.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.w600
                                      //fontWeight: FontWeight.w500,
                                      ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                      const Spacer(),
                      // CircleAvatar(
                      //   backgroundColor: BackgroundGrey1,
                      //   radius: 30.r,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(3.0),
                      //     child: CircleAvatar(
                      //       radius: 28.r,
                      //       backgroundImage: const AssetImage(
                      //         'assets/profile.jpg',
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      controller.text = value;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: primaryGreen,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      hintText: 'Search here...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.onPrimary,
                        //fontWeight: FontWeight.w500,
                      ),
                    ),
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                pinned: true,
                elevation: 0.0,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(105.h),
                  child: Container(
                    alignment: Alignment.center,
                    //color: Colors.red,
                    //padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: Column(
                      children: [
                        //buildLabel(label: 'Category'),
                        buildLabel(
                          context: context,
                          label: 'Category',
                          onPressed: () {
                            showBottomSheet(
                              backgroundColor: Colors.black12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    (6.r),
                                  ),
                                  topRight: Radius.circular(
                                    (6.r),
                                  ),
                                ),
                              ),
                              context: context,
                              builder: (context) => Padding(
                                padding: EdgeInsets.all(24.0.w),
                                child: Container(
                                  color: backgroundGrey2,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 24.0.h),
                                  height: 720.h,
                                  width: double.infinity,
                                  child: GridView(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    children: List.generate(
                                      category.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 50.h,
                                          width: 80.w,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(6.r)),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              getImage(
                                                  folderName: 'category',
                                                  fileName: category[index]),
                                              height: 50.h,
                                              color: primaryGreen,
                                              fit: BoxFit.cover,
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
                        ),
                        buildCategory(),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: buildLabel(
                  context: context,
                  label: 'Find Doctors ',
                  onPressed: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: buildListOfDoctor(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel({
    required BuildContext context,
    required String label,
    required Function()? onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, top: 2.h, right: 10.w, bottom: 2.h),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'See all',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: primaryGreen,
                //fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: SizedBox(
        height: 105.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 50.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(6.r)),
              child: Center(
                child: SvgPicture.asset(
                  getImage(folderName: 'category', fileName: category[index]),
                  height: 50.h,
                  color: primaryGreen,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildListOfDoctor(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    // List<String> docs = [
    //   'assets/doc.jpg',
    //   'assets/doc (1).jpg',
    //   'assets/doc (2).jpg',
    //   'assets/doc (3).jpg',
    //   'assets/doc (4).jpg',
    //   'assets/doc (5).jpg',
    // ];

    return StreamBuilder(
      stream: _firebaseFirestore
          .collection("doctors")
          .where('name', isEqualTo: controller.text)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!.docs;
        // final doctorDocumentID = _firebaseFirestore
        //     .collection("doctors")
        //     .doc()
        //     .get()
        //     .then((value) => value.id);

        // _firebaseFirestore.collection("doctors").get().then((querySnapshot) {
        //   querySnapshot.docs.forEach((element) {
        //     var id = element.id; // randomly generated document ID
        //     var data = element.data(); // key-value pairs from the document

        //     debugPrint(id);
        //     debugPrint(data.keys.toString());
        //   });
        // });

        // ((doc) {});

        //(doctorDocumentID);

        List<Widget> doctorCards = [];
        List<String> documentID = [];
        List<String> profilePic = [];

        for (var item in data) {
          final fetchedData = item.data();

          documentID.add(item.id);
          profilePic.add(item.get('profilePic'));

          final doctorCardItem = Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            height: 120.h,
            width: 353.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 80,
                  margin: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Hero(
                      tag: fetchedData['profilePic'],
                      child: Image.network(
                        fetchedData['profilePic'],
                        fit: BoxFit.fitHeight,
                      ),
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
                        fetchedData['name'],
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600
                            //fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        fetchedData['speciality'],
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          doctorCards.add(doctorCardItem);
        }

        return data.isNotEmpty
            ? ListView.builder(
                itemCount: doctorCards.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    getPage(
                        context,
                        DoctorInfo(
                          imageString: profilePic[index],
                          uid: documentID[index],
                        ));
                  },
                  child: doctorCards[index],
                ),
              )
            : Center(
                child: Container(
                  //color: Colors.red,
                  height: 350.h,
                  child: Center(
                    child: textLabel(text: 'No results', color: midGrey1),
                  ),
                ),
              );
      }),
    );
  }
}



// ListView.builder(
//       shrinkWrap: true,
//       itemCount: docs.length,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) => GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: ((context) => DoctorInfo(
//                     imageString: docs[index],
//                   )),
//             ),
//           );
//         },
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
//           padding: EdgeInsets.symmetric(vertical: 8.h),
//           height: 120.h,
//           width: 353.w,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6.r),
//             color: Theme.of(context).colorScheme.primaryContainer,
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 100,
//                 width: 80,
//                 margin: const EdgeInsets.all(8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(6.r),
//                   child: Hero(
//                     tag: docs[index],
//                     child: Image.asset(
//                       docs[index],
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Naza Qadir',
//                       style: GoogleFonts.poppins(
//                           fontSize: 16.sp,
//                           color: Theme.of(context).colorScheme.onPrimary,
//                           fontWeight: FontWeight.w600
//                           //fontWeight: FontWeight.w500,
//                           ),
//                     ),
//                     Text(
//                       'Cardiologist',
//                       style: GoogleFonts.poppins(
//                         fontSize: 14.sp,
//                         color: Theme.of(context).colorScheme.onPrimary,
//                         //fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );