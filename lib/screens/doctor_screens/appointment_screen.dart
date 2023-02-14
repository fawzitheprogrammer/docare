import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docare/components/components_barrel.dart';
import 'package:docare/public_packages.dart';
import 'package:docare/state_management/providers_barrel.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentScreen extends StatelessWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildAppointmentList(),
    );
  }

  Widget buildAppointmentList() {
    final _firestore = FirebaseFirestore.instance;

    return StreamBuilder(
      stream: _firestore.collection('doctors').snapshots(),
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
        for (var i in item) {
          final itemData = i.data();
          final bool fecthedData = itemData['isApproved'];
          isApproved = fecthedData;
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  getImage(folderName: 'vectors', fileName: 'waiting.svg'),
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
                  color: Theme.of(context).colorScheme.onPrimary.withAlpha(100),
                  textAlign: TextAlign.center,
                  fontSize: 12.sp,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
