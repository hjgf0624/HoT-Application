// import 'package:flutter/material.dart';
// import 'package:capstone_project/reusable_widgets/reusable_widget.dart';
// import 'package:capstone_project/screens/signup_screen.dart';
// import 'package:capstone_project/utils/color_utils.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//               hexStringToColor("FF4D80"),
//               hexStringToColor("FF3E41"),
//               hexStringToColor("DF367C"),
//             ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
//         child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(
//                   20, MediaQuery.of(context).size.height * 0.2, 20, 0),
//               child: Column(children: <Widget>[
//                 logoWidget("assets/images/Hot.png"),
//                 SizedBox(
//                   height: 50,
//                   width: 50,
//                 ),
//                 reusableTextField("이메일을 입력하세요.", Icons.person_outline, false,
//                     _emailTextController),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("비밀번호를 입력하세요.", Icons.lock_outline, true,
//                     _passwordTextController),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 signInSignUpButton(context, true, () {}),
//                 signUpOption()
//               ]),
//             )),
//       ),
//     );
//   }
//
//   Row signUpOption() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "계정이 없으신가요?",
//           style: TextStyle(color: Colors.white70),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => SignUpScreen()));
//           },
//           child: const Text(
//             " 회원가입",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         )
//       ],
//     );
//   }
// }