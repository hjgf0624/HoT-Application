import 'package:capstone_project/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './signupPage.dart';
import './result.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
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
          scaffoldBackgroundColor: const Color.fromARGB(255, 24, 20, 35),
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

  final logger = Logger();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();


  Future<void> signin() async{
    try{
      print('로그인 버튼 클릭');
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
      );

      User user = userCredential.user!;
      print('로그인 성공 : ${user.email}');

      Navigator.push(context, MaterialPageRoute(builder: ((context) => Result())));
    } catch(e, stackTrace){
      print('예외 발생: $e');
      print('스택 트레이스 : $stackTrace');
      // logger.e('오류 발생: $e', e, stackTrace);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: size.height*0.04,),
                const Text('HoT',
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
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: '아이디를 입력하세요',
                      hintStyle: const TextStyle(color: Colors.white),
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
                SizedBox(
                  width: size.width*0.8,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: '비밀번호를 입력하세요.',
                      hintStyle: const TextStyle(color: Colors.white),
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
                  margin: const EdgeInsets.only(top: 16),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState !=null && _formKey.currentState!.validate()) {
                        signin();
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(Size(size.width * 0.8, size.height * 0.1)),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: OutlinedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        signin();
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Colors.yellow,
                        minimumSize: Size(size.width*0.8, size.height*0.1)
                    ),
                    child: const Text(
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
                      child: const Text(
                          '회원가입',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => ResetPw())));
                        },
                        child: const Text(
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