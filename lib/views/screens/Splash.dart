// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // ignore: camel_case_types
// class splashScreen extends StatefulWidget {
//   const splashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<splashScreen> createState() => _splashScreenState();
// }
//
// // ignore: camel_case_types
// class _splashScreenState extends State<splashScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//     Timer(const Duration(seconds: 1),() {
//       Get.offNamed('/Bottom');
//     },);
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xff033E5E),
//         body: Center(
//           child: Image.asset("assets/images/r.png",color: const Color(0xfffed25c)),
//         ),
//       ),
//     );
//   }
// }