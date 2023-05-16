import 'package:capstone_project/main.dart';
import 'package:flutter/material.dart';
import './result.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final logger = Logger();

  final _formKey= GlobalKey<FormState>();
  final TextEditingController _name= TextEditingController();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  final TextEditingController _passwordConfirm= TextEditingController();
  final TextEditingController _phoneNum= TextEditingController();
  final TextEditingController _authNum= TextEditingController();

  Future<void> signup() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text);
    }catch(e, stackTrace){
      logger.e('오류 발생: $e', e, stackTrace);
    }
    Navigator.push(context,MaterialPageRoute(builder:((context)=>Result())));
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: size.height*0.03,left: size.height*0.04,right: size.height*0.04,),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'HoT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Prismakers',
                        color: Colors.white,
                        fontSize: 50
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  const Text(
                    '회원가입',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: size.height*0.03,),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: '이메일',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '이메일 입력',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color:  Colors.white,
                              width: 1,
                              // style: BorderStyle.solid
                            )
                        )
                    ),
                    controller: _email,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '이메일을 입력해 주세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.02,),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: '비밀번호',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '비밀번호 입력',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color:Colors.white,
                            width: 1,
                          )
                        )
                    ),
                    controller: _password,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '비밀번호를 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.02,),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: '비밀번호 확인',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '비밀번호 재입력',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          )
                        )
                    ),
                    controller: _passwordConfirm,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '비밀번호를 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.03,),
                  TextFormField(
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                        labelText: '이름',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '이름 입력',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color:  Colors.white,
                              width: 1,
                              // style: BorderStyle.solid
                            )
                        )
                    ),
                    controller: _name,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '이름을 입력해 주세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.03,),
                  TextFormField(
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                        labelText: '전화번호',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '휴대폰 번호 입력. (11자리)',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color:  Colors.white,
                              width: 1,
                              // style: BorderStyle.solid
                            )
                        )
                    ),
                    controller: _phoneNum,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '휴대폰 번호를 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.03,),
                  TextFormField(
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                        labelText: '인증번호 확인',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '인증번호 입력(4자리)',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color:  Colors.white,
                              width: 1,
                              // style: BorderStyle.solid
                            )
                        )
                    ),
                    controller: _authNum,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '인증번호를 입력해 주세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              signup();
                            }
                          },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Colors.white,
                          minimumSize: Size(size.width*0.3, size.height*0.1)
                        ),
                          child: const Text(
                              '가입하기',
                            style: TextStyle(
                              color:Colors.red
                            ),
                          ),
                      ),
                      OutlinedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: Colors.white,
                            minimumSize: Size(size.width*0.3, size.height*0.1)
                        ),
                        child: const Text(
                          '가입취소',
                          style: TextStyle(
                              color:Colors.red
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        )
    );
  }
}