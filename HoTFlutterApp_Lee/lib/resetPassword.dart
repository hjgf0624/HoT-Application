import 'package:untitled2/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AuthExceptionHandler.dart';

class ResetPw extends StatefulWidget {
  const ResetPw({super.key});

  @override
  State<ResetPw> createState() => _ResetPwState();
}

class _ResetPwState extends State<ResetPw> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = new TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthStatus _status;

  Future<AuthStatus> resetPassword({required String email}) async {
    await _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: size.height*0.05,),
                  const Text(
                    'HoT',
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
                  SizedBox(height: size.height*0.05,),
                  Container(
                    width: size.width*0.8,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: '이메일',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '이메일을 입력하세요',
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
                          return '이메일을 입력하세요.';
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextButton(
                      onPressed: () async{
                        if(_formKey.currentState!.validate()) {
                          final _status = await resetPassword(email: _email.text.trim());
                        }
                        if(_status == AuthStatus.successful) {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage())));
                        } else {
                          final error = AuthExceptionHandler.generateErrorMessage(_status);
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
                        '비밀번호 리셋 메일 전송',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage())));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        minimumSize: MaterialStateProperty.all<Size>(Size(size.width * 0.8, size.height * 0.1)),
                      ),
                      child: const Text(
                        '홈으로 돌아가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}