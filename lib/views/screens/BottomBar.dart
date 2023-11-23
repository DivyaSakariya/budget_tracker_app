//
// import 'package:database/Screen/Home/view/FilterScreen.dart';
// import 'package:database/Screen/Home/view/homeScreen.dart';
// import 'package:flutter/material.dart';
//
// import 'Transaction_page.dart';
//
// class Bottom extends StatefulWidget {
//   const Bottom({Key? key}) : super(key: key);
//
//   @override
//   State<Bottom> createState() => _BottomState();
// }
//
// class _BottomState extends State<Bottom> {
//   int i = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFF17202A),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: i,
//           type: BottomNavigationBarType.shifting,
//           onTap: (value) {
//             setState(() {
//               i = value;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//               backgroundColor: Color(0xFF17202A),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.graphic_eq),
//               label: "Transactions",
//               backgroundColor: Color(0xFF17202A),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.filter_alt_rounded),
//               label: "Filter",
//               backgroundColor: Color(0xFF17202A),
//             ),
//           ],
//           selectedItemColor: const Color(0xFF32B3DF),
//           unselectedItemColor: Colors.grey.shade600,
//           backgroundColor: const Color(0xFF17202A),
//         ),
//         body: IndexedStack(
//           index: i,
//           children: const [
//             HomePage(),
//             Transaction_page(),
//             FilterScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
