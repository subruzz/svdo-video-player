// import 'package:flutter/material.dart';

// class SaveButton extends StatelessWidget {
//   const SaveButton(
//       {super.key, required this.progressVisibilily, required this.saveVideo});
//   final bool progressVisibilily;
//   final Function() saveVideo;
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         foregroundColor: Colors.white,
//         shadowColor: Colors.blueAccent,
//         elevation: 5.0,
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//       ),
//       onPressed: progressVisibilily ? null : () => saveVideo(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//        const    Icon(
//             Icons.save,
//             color: Colors.black,
//           ),
//           const SizedBox(width: 10.0),
//           Text('Save', style: Theme.of(context).textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }
// }
