import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/navigation/navigator.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/screens/user_screens/doctor_info_screen.dart';

import '../../components/components_barrel.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: firebaseFirestore
            .collection('doctors')
            .where('isFav', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: primaryGreen,
            ));
          }

          final item = snapshot.data!.docs;

          List<Widget> doctors = [];
          for (var fetchedData in item) {
            final favCard = GestureDetector(
              onTap: () => getPage(
                  context,
                  DoctorInfo(
                    imageString: fetchedData.get('profilePic'),
                    uid: fetchedData.id,
                  )),
              child: Container(
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Image.network(
                          fetchedData.get('profilePic'),
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
                            fetchedData.get('name'),
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600
                                //fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            fetchedData.get('speciality'),
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.onPrimary,
                              //fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        updateDocuemnt(
                          firestore: firebaseFirestore,
                          parentCollection: 'doctors',
                          doctorDocumentID: fetchedData.id,
                          isFav: fetchedData.get('isFav'),
                        );
                      },
                      child: SvgPicture.asset(
                        getImage(
                          folderName: 'icons',
                          fileName: 'heart_filled.svg',
                        ),
                        color: primaryGreen,
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                  ],
                ),
              ),
            );

            doctors.add(favCard);
          }

          return doctors.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.all(12.0.w),
                  child: ListView(
                    children: doctors,
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0.w),
                            child: SvgPicture.asset(
                              getImage(
                                folderName: 'icons',
                                fileName: 'favorites.svg',
                              ),
                              width: 100.h,
                            ),
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
                          text: 'You have no favourites yet.',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp),
                      textLabel(
                        text: 'All your favourites appear in this screen.',
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withAlpha(120),
                      ),
                    ],
                  ),
                );
        },
      )),
    );
  }
}
