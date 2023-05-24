import 'package:capstone_project/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './signupPage.dart';
import './result.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:logger/logger.dart';
import 'firebase_options.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/src/model/user.dart' as KakaoUser;


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug
  );
  KakaoSdk.init(
      nativeAppKey: 'c1de913802f912339a8a3ade2cebe670',
      javaScriptAppKey: 'b06764f4a0759c738492c42e601e2a44'
  );
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

  Future<void> signinWithKakao() async{

    if (await isKakaoTalkInstalled()) {
      try {
        print('카카오톡으로 로그인 성공');
        UserApi.instance.loginWithKakaoTalk();
        Navigator.push(context, MaterialPageRoute(builder: ((context) => Result())));
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          print('카카오계정으로 로그인 성공');
          UserApi.instance.loginWithKakaoAccount();

          Navigator.push(context, MaterialPageRoute(builder: ((context) => Result())));
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        print('카카오계정으로 로그인 성공');
        UserApi.instance.loginWithKakaoAccount();
        Navigator.push(context, MaterialPageRoute(builder: ((context) => Result())));
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  Future<void> signin() async{
    try{
      print('로그인 버튼 클릭');
      FirebaseAuth.UserCredential userCredential = await FirebaseAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
      );

      FirebaseAuth.User user = userCredential.user!;
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
                        signinWithKakao();
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