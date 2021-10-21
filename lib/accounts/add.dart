// // Flutter imports:
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class AddData extends StatelessWidget {
//   const AddData({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF020925),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color(0xFF020925),
//         title: const Text(
//           'Add account',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: const Color(0xFF13254C).withOpacity(1),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       "Group",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       width: MediaQuery.of(context).size.width - 80,
//                       child: const TextField(
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       "Name",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       width: MediaQuery.of(context).size.width - 80,
//                       child: const TextField(
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       "Amount",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       width: MediaQuery.of(context).size.width - 80,
//                       child: const TextField(
//                         keyboardType: TextInputType.number,
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       "Note",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     const SizedBox(
//                       width: 30,
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       width: MediaQuery.of(context).size.width - 80,
//                       child: const TextField(
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: FlatButton(
//               height: 30,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               color: Colors.red,
//               minWidth: MediaQuery.of(context).size.width - 100,
//               onPressed: () {
//                 debugPrint("Saved");
//               },
//               child: const Text(
//                 "Save",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
