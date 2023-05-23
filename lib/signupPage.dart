import 'package:capstone_project/FirebaseService.dart';
import 'package:capstone_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './result.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FirebaseService.dart' as firebase_service;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final logger = Logger(); // 로그 확인하기 위한 생성자

  final _formKey= GlobalKey<FormState>();
  // 회원가입 정보 [이름, 이메일, 패스워드, 휴대폰 번호] //
  final TextEditingController _name= TextEditingController();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  final TextEditingController _passwordConfirm= TextEditingController();
  final TextEditingController _phoneNum= TextEditingController();
  final TextEditingController _authNum= TextEditingController();

  late String verificationId; // 인증번호, 초기화는 인증번호를 발급받은 뒤에 해 주기 때문에 late

  // 회원가입 전, 체크해야 할 항목들 [인증번호 확인, 이메일 중복여부, 이메일 중복체크, 비밀번호 확인]
  bool isVerificationSuccessful = false;
  bool isEmailDuplicated = false;
  bool isEmailChecked = false;
  bool passwordMatch = true;


  String formatPhoneNumber(String phoneNumber) { // 휴대폰번호를 국가번호로 바꿔주는 메소드
    if(phoneNumber.startsWith('010')) {
      phoneNumber = phoneNumber.replaceFirst('010', '10');
    }

    return '+82$phoneNumber';
  }

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth 인스턴스 생성

  final FirebaseService firebaseService = FirebaseService(); // FirebaseService (FireStore 인스턴스 생성)

  Future<bool> checkEmailDuplication(String email) async { // 회원가입 이메일 중복체크 메소드
    List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async { // 전화번호로 인증번호 전송하는 메소드

    String formattedPhoneNumber = formatPhoneNumber(phoneNumber);

    await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential){
          signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e){
          print('인증 실패: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken){
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId){
          setState(() {
            this.verificationId = verificationId;
          });
        });
  }

  Future<void> signInWithSmsCode(String smsCode) async { // 인증번호 확인 메소드
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await signInWithCredential(credential);
      isVerificationSuccessful = true;
    } catch (e) {
      print('인증 실패: $e');
    }
  }

  Future<void> signInWithCredential(AuthCredential credential) async { // Firebase 인증 완료
    try {
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      // 인증 완료 후 추가 로직 수행
    } catch (e) {
      print('인증 실패: $e');
    }
  }

  Future<void> signup() async{ // 회원가입을 처리하는 메소드
    try{
      if(!isEmailDuplicated && isEmailChecked && isVerificationSuccessful) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text);

        String userId = userCredential.user!.uid;
        firebase_service.UserInfo userInfo= firebase_service.UserInfo(
            email: _email.text,
            name: _name.text,
            phoneNum: _phoneNum.text);

        await FirebaseFirestore.instance.collection('users').doc(userId).set(userInfo.toMap());


        Navigator.push(context,MaterialPageRoute(builder:((context)=>Result())));
      }
      else print('이메일 중복체크를 하지 않으셨거나 인증번호 확인이 되지 않았습니다.');
    }catch(e, stackTrace){
      logger.e('오류 발생: $e', e, stackTrace);
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height*0.03,),
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

                  SizedBox(height: size.height*0.05,),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: '이메일',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintText: '이메일 입력',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          controller: _email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '이메일을 입력해 주세요.';
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool isDuplicated = await checkEmailDuplication(_email.text);
                            setState(() {
                              isEmailDuplicated = isDuplicated;
                              isEmailChecked = true;
                            });
                          },
                          child: const Text('이메일 중복체크'),
                        ),
                      ),
                      if (isEmailChecked && isEmailDuplicated)
                        Positioned(
                          bottom: -2,
                          left: 2,
                          child: Container(
                            child: const Text(
                              '중복된 이메일입니다.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      if (isEmailChecked && !isEmailDuplicated)
                        Positioned(
                          bottom: -2,
                          left: 2,
                          child: Container(
                            child: const Text(
                              '사용 가능한 이메일입니다.',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: size.height*0.02,),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFormField(
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
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*0.02,),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: '비밀번호 확인',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: '비밀번호 재입력',
                              hintStyle: const TextStyle(color: Colors.white),
                              // errorText: passwordMatch ? null : '비밀번호가 일치하지 않습니다',
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
                            if(_password.text.isNotEmpty && value!=_password.text){
                              setState(() {
                                passwordMatch = false;
                              });
                              return '비밀번호가 일치하지 않습니다.';
                            } else {
                              setState(() {
                                passwordMatch = true;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  // if(passwordMatch)
                  //   const Positioned(
                  //     top: 0,
                  //     left: 0,
                  //     child: Text(
                  //       '비밀번호가 일치합니다.',
                  //       style: TextStyle(color: Colors.green),
                  //     ),
                  //   ),
                  SizedBox(height: size.height*0.03,),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white,),
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
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*0.03,),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white,),
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(11),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return '휴대폰 번호를 입력하세요.';
                            }
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: double.infinity,
                          child: ElevatedButton(

                            onPressed: () async {
                              if(_phoneNum.text.isNotEmpty){
                                await verifyPhoneNumber(_phoneNum.text);
                              }
                              else {
                                print('휴대폰 번호가 입력되지 않았습니다.');
                              }
                            },
                            child: const Text('인증번호 전송'),
                          ),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*0.03,),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white,),
                          decoration: InputDecoration(
                              labelText: '인증번호 확인',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: '인증번호 입력(6자리)',
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(6),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return '인증번호를 입력해 주세요.';
                            }
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: SizedBox(
                          height: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await signInWithSmsCode(_authNum.text);
                            },
                            child: const Text('인증번호 확인'),
                          )
                        ),
                      ),
                      if(isVerificationSuccessful)
                        const Positioned(
                          bottom: -2,
                          left: 2,
                          child: Text(
                            '인증번호 확인 완료',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),

                    ],
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