// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:capstone_project/screens/signin_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CapStone Desing Project',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const SignInScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import './loginPage.dart';
import './signupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {




  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: size.height,
            height: size.height,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 94, 251) ),
            child: Column(
              children: [
                SizedBox(height: size.height*0.2,),
                Text('HoT\n전북대 소프트웨어학과 캡스톤 프로젝트',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: size.height*0.1,),
                Container(
                    width: size.height,
                    height: size.height*0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)  )),
                    child: Column(
                      children: [
                        SizedBox(height: size.height*0.075,),
                        Text('환영합니다',
                          style: TextStyle(

                              fontSize: 20,
                              fontWeight: FontWeight.bold ),
                        ),
                        SizedBox(height: size.height*0.02,),
                        Text('헬스 IoT 시스템입니다.',
                          style: TextStyle(

                            fontSize: 18,

                          ),
                        ),
                        SizedBox(height: size.height*0.03,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                          child: Container(
                            width:size.width*0.9,
                            height: size.height*0.08,
                            decoration: BoxDecoration(
                                color:  Color.fromARGB(255, 4, 94, 251),
                                borderRadius: BorderRadius.all(Radius.circular(15),
                                )
                            ),
                            child:Center(child: Text('회원가입',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,

                              ),
                            )) ,
                          ),
                        ),
                        SizedBox(height: size.height*0.015 ,),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                          },
                          child: Container(
                            width:size.width*0.9,
                            height: size.height*0.08,
                            decoration: BoxDecoration(
                                color:  Color.fromARGB(255, 4, 94, 251),
                                borderRadius: BorderRadius.all(Radius.circular(15),
                                )
                            ),
                            child:Center(child: Text('로그인',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,

                              ),
                            )) ,
                          ),
                        )

                      ],
                    )  ),


              ],
            ),
          ),
        )
    );
  }

}