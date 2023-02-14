import 'package:docare/public_packages.dart';

import '../../components/components_barrel.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => Container(
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
                        'Naza Qadir',
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w600
                            //fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        'Cardiologist',
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
        ),
      ),
    );
  }
}
