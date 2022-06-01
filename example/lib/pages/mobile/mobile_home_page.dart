// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../../extension.dart';
// import '../month_view_page.dart';
// import '../../login_app/login_refactor.dart';
//
// class MobileHomePage extends StatelessWidget {
//   // var isLogined = false;
//   // var state_num = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(102, 102, 153, 1),
//       appBar: AppBar(
//         title: Text("T4 Calendar",
//           style: TextStyle(
//             fontFamily: 'Noto_Sans_KR',
//             fontSize: 25.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Color.fromRGBO(102, 102, 153, 1),
//
//         // #################### 로그아웃 아이콘 버튼 ###################
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.exit_to_app_sharp,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               //FirebaseAuth.instance.currentUser?.displayName; .. 현재 유저
//               FirebaseAuth.instance.currentUser?.displayName;
//               FirebaseAuth.instance.signOut();
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LogInRefac()),
//               );
//             },
//           )
//         ],
//       ),
//
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             OutlinedButton(
//               onPressed: () => context.pushRoute(MonthViewPageDemo()),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.1)),
//                   minimumSize: MaterialStateProperty.all(Size(150, 60)) ,
//                   side: MaterialStateProperty.all(BorderSide(
//                       color: Color.fromRGBO(255, 255, 255, 0.5),
//                       width: 1.0,
//                       style: BorderStyle.solid))
//               ),
//
//               child: Text("T4 Calendar",
//                 style: TextStyle(
//                   fontFamily: 'Noto_Sans_KR',
//                   fontSize: 20.0,
//                   color: Color.fromARGB(255, 255, 255, 255),
//                 ),
//               ),
//             ),
//             SizedBox(height: 100),
//             OutlinedButton(
//               onPressed: () => context.pushRoute(MonthViewPageDemo()),
//
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.1)),
//                   minimumSize: MaterialStateProperty.all(Size(150, 60)) ,
//                   side: MaterialStateProperty.all(BorderSide(
//                       color: Color.fromRGBO(255, 255, 255, 0.5),
//                       width: 1.0,
//                       style: BorderStyle.solid))
//               ),
//
//               child: Text("로그인",
//                 style: TextStyle(
//                   fontFamily: 'Noto_Sans_KR',
//                   fontSize: 20.0,
//                   color: Colors.white,
//                   letterSpacing: 5,
//                 ),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
