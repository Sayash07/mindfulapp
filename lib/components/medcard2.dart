import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MedCard2 extends StatelessWidget {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final String medID;
  final VoidCallback refreshCallback;

  MedCard2({
    super.key,
    required this.medID,
    required this.refreshCallback,
  });

  Future<DocumentSnapshot> getMedData() async {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .collection('Medications')
        .doc(medID)
        .get(const GetOptions(source: Source.cache));
  }

  String categoryImagePath(String catgoryStr) {
    switch (catgoryStr) {
      case 'Capsule':
        return 'lib/assets/icons/pills.png';
      case 'Tablet':
        return 'lib/assets/icons/tablet.png';
      case 'Liquid':
        return 'lib/assets/icons/liquid.png';
      case 'Topical':
        return 'lib/assets/icons/tube.png';
      case 'Cream':
        return 'lib/assets/icons/cream.png';
      case 'Drops':
        return 'lib/assets/icons/drops.png';
      case 'Foam':
        return 'lib/assets/icons/foam.png';
      case 'Gel':
        return 'lib/assets/icons/tube.png';
      case 'Herbal':
        return 'lib/assets/icons/herbal.png';
      case 'Inhaler':
        return 'lib/assets/icons/inhalator.png';
      case 'Injection':
        return 'lib/assets/icons/syringe.png';
      case 'Lotion':
        return 'lib/assets/icons/lotion.png';
      case 'Nasal Spray':
        return 'lib/assets/icons/nasalspray.png';
      case 'Ointment':
        return 'lib/assets/icons/tube.png';
      case 'Patch':
        return 'lib/assets/icons/patch.png';
      case 'Powder':
        return 'lib/assets/icons/powder.png';
      case 'Spray':
        return 'lib/assets/icons/spray.png';
      case 'Suppository':
        return 'lib/assets/icons/suppository.png';
      default:
        return 'lib/assets/icons/medicine.png';
    }
  }

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic>? medData = snapshot.data!.data() != null
                ? snapshot.data!.data() as Map<String, dynamic>
                : <String, dynamic>{};
            //data
            String? medname = medData['medname'];
            String? category = medData['category'];
            String? frequency = medData['frequency'];
            String? times = medData['times'];
            int? medcount = medData['medcount'];
            String? strength = medData['strength'] != null
                ? '${medData['strength']} ${medData['strength_unit']}'
                : null;
            return GestureDetector(
              onTap: () {
                int now = DateTime.now().millisecondsSinceEpoch;
                if (now - lastTap < 1000) {
                  print("Consecutive tap");
                  consecutiveTaps++;
                  print("taps = $consecutiveTaps");
                  if (consecutiveTaps >= 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Long tap to delete medication'),
                        backgroundColor: Color.fromARGB(255, 46, 143, 202),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  consecutiveTaps = 0;
                }
                lastTap = now;
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure want to delete "$medname"?'),
                      actions: [
                        TextButton(
                          child: Text(
                            'OK',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(currentUser!.email)
                                .collection('Medications')
                                .doc(medID)
                                .delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    const Color.fromARGB(255, 7, 83, 96),
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                                content: Text(
                                  '"$medname" deleted successfully',
                                ),
                              ),
                            );

                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 76, 112, 117),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 174, 194, 197),
                        blurRadius: 5.0,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //category icon
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          categoryImagePath(category!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //medication name
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //medication name
                        Text(
                          medname!,
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //dosage
                        Visibility(
                          visible: strength != null,
                          child: Column(
                            children: [
                              Text(
                                strength.toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        //dosage
                        Text(
                          '$medcount $category(s) $frequency',
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //times
                        SizedBox(
                          width: 200,
                          child: Text(
                            times!,
                            maxLines: 8,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              width: double.infinity,
              height: 120.0,
              margin: const EdgeInsets.fromLTRB(50, 20, 25, 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.signal_wifi_off_rounded,
                      color: Colors.grey.shade600),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Network Error',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: const SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BannerPlaceholder(),
                  ],
                ),
              ));
        }
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: const SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BannerPlaceholder(),
                ],
              ),
            ));
      },
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.0,
      margin: const EdgeInsets.fromLTRB(50, 20, 25, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
    );
  }
}
