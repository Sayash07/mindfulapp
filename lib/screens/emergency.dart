import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/language_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _Emergency();
}

class _Emergency extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).emgcall,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 5.0,
      ),
      // body: Center(
      // child: ElevatedButton(
      //   onPressed: () async{
      //     final Uri url =Uri(
      //       scheme: 'tel',
      //       path: "+94714686902"
      //     );
      //     if (await canLaunchUrl(url)){
      //       await launchUrl(url);
      //     }
      //     else{
      //       print('cannot launch');
      //     }
      //             },
      //   child:const Text("Call"),
      // ),
      // ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'lib/assets/icons/emergency-call.gif',
                color: const Color.fromARGB(255, 241, 250, 251),
                colorBlendMode: BlendMode.darken,
                height: 80.0,
              ),
            ),
            const SizedBox(height: 40),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("4412404"),
              icon: FontAwesomeIcons.truckMedical,
              label: translation(context).ssa,
              number: '4412404',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("103"),
              // icon: Icons.accessible_outlined,
              icon: FontAwesomeIcons.personFallingBurst,
              label: translation(context).as,
              number: '103',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("100"),
              icon: Icons.local_police_outlined,
              label: translation(context).pi,
              number: '100',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("101"),
              icon: Icons.fire_truck_outlined,
              label: translation(context).fi,
              number: '101',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("4211527"),
              icon: Icons.info_outline,
              label: translation(context).gv,
              number: '4211527',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("106"),
              icon: Icons.emergency_outlined,
              label: translation(context).eps,
              number: '106',
            ),
            _EmergencyButton(
              onPressed: () => _makeEmergencyCall("1098"),
              icon: Icons.child_care,
              label: 'Missing Child Response',
              number: '1098',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makeEmergencyCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print(translation(context).ctL);
    }
  }
}

class _EmergencyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final String number;

  const _EmergencyButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(221, 38, 38, 38),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  color: Color.fromARGB(221, 38, 38, 38),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                number,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const Spacer(), // Pushes the content to the left
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.call_outlined,
              color: Color.fromARGB(221, 38, 38, 38),
            ),
            // style: ElevatedButton.styleFrom(
            //   backgroundColor: const Color.fromARGB(255, 197, 197, 197),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

// children:[
//   Column(mainAxisAlignment: MainAxisAlignment.center,
//    children: [
//   Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       Container(
//         width: 360,
//         height: 80,
//         child: ElevatedButton.icon(
//           onPressed: () async{
//   final Uri url =Uri(
//     scheme: 'tel',
//     path: "+94714686902"
//   );
//   if (await canLaunchUrl(url)){
//     await launchUrl(url);
//   }
//   else{
//     print('cannot launch');
//   }
//           },
//           icon: const Icon(
//             Icons.call,
//             color: Colors.black,
//           ),
//           label: const Text('Police Emergency - 119',
//               style: TextStyle(color: Colors.black)),
//           style: ElevatedButton.styleFrom(
//               backgroundColor:const Color.fromARGB(255, 153, 155, 153),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               )
//               ),
//         ),
//       ),
//     ],
//   ),
// const SizedBox(
//   height: 40,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Container(
//       width: 360,
//       height: 80,
//       child: ElevatedButton.icon(
//         onPressed: () async{
// final Uri url =Uri(
//   scheme: 'tel',
//   path: "+94714686902"
// );
// if (await canLaunchUrl(url)){
//   await launchUrl(url);
// }
// else{
//   print('cannot launch');
// }
//         },
//         icon: const Icon(
//           Icons.call,
//           color: Colors.black,
//         ),
//         label: const Text('Government Information Center - 1919',
//             style: TextStyle(color: Colors.black)),
//         style: ElevatedButton.styleFrom(
//           backgroundColor:const Color.fromARGB(255, 153, 155, 153),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
// const SizedBox(
//   height: 40,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Container(
//       width: 360,
//       height: 80,
//       child: ElevatedButton.icon(
//         onPressed: () async{
// final Uri url =Uri(
//   scheme: 'tel',
//   path: "+94714686902"
// );
// if (await canLaunchUrl(url)){
//   await launchUrl(url);
// }
// else{
//   print('cannot launch');
// }
//         },
//         icon: const Icon(
//           Icons.call,
//           color: Colors.black,
//         ),
//         label: const Text('Suwa Seriya Ambulance - 1990',
//             style: TextStyle(color: Colors.black)),
//         style: ElevatedButton.styleFrom(
//           backgroundColor:const Color.fromARGB(255, 153, 155, 153),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
// const SizedBox(
//   height: 40,
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Container(
//       width: 360,
//       height: 80,
//       child: ElevatedButton.icon(
//         onPressed: () async{
// final Uri url =Uri(
//   scheme: 'tel',
//   path: "+94714686902"
// );
// if (await canLaunchUrl(url)){
//   await launchUrl(url);
// }
// else{
//   print('cannot launch');
// }
//         },
//         icon: const Icon(
//           Icons.call,
//           color: Colors.black,
//         ),
//         label: const Text('Ambulance / Fire & rescue - 110',
//             style: TextStyle(color: Colors.black,),),
//         style: ElevatedButton.styleFrom(
//           backgroundColor:const Color.fromARGB(255, 153, 155, 153),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
//           ],
//           ),
//           ]
//       ),
//       ),

//     );
//   }
// }
