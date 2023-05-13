// import 'package:flutter/material.dart';
// import 'package:capstone_project/reusable_widgets/reusable_widget.dart';
// import 'package:capstone_project/screens/home_screen.dart';
// import 'package:capstone_project/utils/color_utils.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   TextEditingController _userNameTextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "회원가입",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
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
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("이름을 입력하세요.", Icons.person_outline, false,
//                     _userNameTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("이메일 ID를 입력하세요.", Icons.person_outline, false,
//                     _emailTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 reusableTextField("비밀번호를 입력하세요.", Icons.lock_outline, true,
//                     _passwordTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 signInSignUpButton(context, false, () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()));
//                 })
//               ]),
//             )),
//       ),
//     );
//   }
// }