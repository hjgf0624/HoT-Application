import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './loginPage.dart';
import './signupPage.dart';
import './result.dart';
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
      title: 'HoT Application',
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 24, 20, 35),
      ),
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
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  
  void signINto(){
    Navigator.push(context, MaterialPageRoute(builder: ((context) => Result())));
  }

  Future<void> signin() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
      );
      print(_email);
    } catch(e)
    { print(e);}

    Navigator.push(context, MaterialPageRoute(builder: ((context) => Result())));
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            alignment: Alignment.center,
           // width: size.width,
           // height: size.height,
           // decoration: BoxDecoration(
           //   color: Color.fromARGB(255, 24, 20, 35) ),
            child: Column(
              children: [
                SizedBox(height: size.height*0.04,),
                Text('HoT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Prismakers',
                  color: Colors.white,
                  fontSize: 50
                ),
                ),
              Container(
                child: Image.asset(
                  'assets/images/HoT_main.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
                SizedBox(height: size.height*0.04,),

                Container(
                  width: size.width*0.8,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: '아이디',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: '아이디를 입력하세요',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        )
                      )
                    ),

                    validator: (value){
                    if(value==null||value.isEmpty){
                      return '아이디를 입력하세요.';
                      }
                    },
                  ),
                ),
                SizedBox(height: size.height*0.02,),
                Container(
                  width: size.width*0.8,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: '비밀번호를 입력하세요.',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderRadius : BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        )
                      )
                    ),
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return '비밀번호를 입력하세요.';
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: OutlinedButton(
                      onPressed: (){
                      if(_formKey.currentState!.validate()){
                        signINto();
                      }
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Colors.white,
                        minimumSize: Size(size.width*0.8, size.height*0.1)
                      ),
                      child: Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: OutlinedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        signINto();
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Colors.yellow,
                        minimumSize: Size(size.width*0.8, size.height*0.1)
                    ),
                    child: Text(
                      '카카오톡으로 로그인',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                          '회원가입',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {

                        },
                        child: Text(
                            '아이디/비밀번호 찾기',
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ));
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     Size size =MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             width: size.height,
//             height: size.height,
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 24, 20, 35) ),
//             child: Column(
//               children: [
//                 SizedBox(height: size.height*0.2,),
//                 Text('HoT',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontFamily: 'Prismakers',
//                       color: Colors.white,
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 SizedBox(height: size.height*0.1,),
//                 Container(
//                     width: size.height,
//                     height: size.height*0.6,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)  )),
//                     child: Column(
//                       children: [
//                         SizedBox(height: size.height*0.075,),
//                         Text('환영합니다',
//                           style: TextStyle(
//
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold ),
//                         ),
//                         SizedBox(height: size.height*0.02,),
//                         Text('헬스 IoT 시스템입니다.',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//
//                           ),
//                         ),
//                         SizedBox(height: size.height*0.03,),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
//                           },
//                           child: Container(
//                             width:size.width*0.9,
//                             height: size.height*0.08,
//                             decoration: BoxDecoration(
//                                 color:  Color.fromARGB(255, 4, 94, 251),
//                                 borderRadius: BorderRadius.all(Radius.circular(15),
//                                 )
//                             ),
//                             child:Center(child: Text('회원가입',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//
//                               ),
//                             )) ,
//                           ),
//                         ),
//                         SizedBox(height: size.height*0.015 ,),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
//                           },
//                           child: Container(
//                             width:size.width*0.9,
//                             height: size.height*0.08,
//                             decoration: BoxDecoration(
//                                 color:  Color.fromARGB(255, 4, 94, 251),
//                                 borderRadius: BorderRadius.all(Radius.circular(15),
//                                 )
//                             ),
//                             child:Center(child: Text('로그인',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//
//                               ),
//                             )) ,
//                           ),
//                         )
//
//                       ],
//                     )  ),
//
//
//               ],
//             ),
//           ),
//         )
//     );
//   }
//
// }