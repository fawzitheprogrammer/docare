import 'package:docare/public_packages.dart';
import 'package:docare/screens/doctor_info_screen.dart';

import '../components/components_barrel.dart';

List<String> category = [
  'stomach.svg',
  'heart.svg',
  'tooth.svg',
  'eye.svg',
  'dermis.svg',
  'kidneys.svg'
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          Text(
                            'Fawzi Gharib',
                            style: GoogleFonts.poppins(
                                fontSize: 28.sp,
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w600
                                //fontWeight: FontWeight.w500,
                                ),
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
                          color: Green,
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
                                  color: BackgroundGrey2,
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                height: 50.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r)),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    getImage(
                                                        folderName: 'category',
                                                        fileName:
                                                            category[index]),
                                                    height: 50.h,
                                                    color: Green,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )),
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
                child: buildListOfDoctor(),
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
                color: Green,
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
                  color: Green,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildListOfDoctor() {
    List<String> docs = [
      'assets/doc.jpg',
      'assets/doc (1).jpg',
      'assets/doc (2).jpg',
      'assets/doc (3).jpg',
      'assets/doc (4).jpg',
      'assets/doc (5).jpg',
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: docs.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => DoctorInfo(
                    imageString: docs[index],
                  )),
            ),
          );
        },
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
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Hero(
                    tag: docs[index],
                    child: Image.asset(
                      docs[index],
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
            ],
          ),
        ),
      ),
    );
  }
}
