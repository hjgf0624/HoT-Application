import 'package:capstone_project/FirebaseService.dart';
import 'package:capstone_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './result.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FirebaseService.dart' as firebase_service;

CollectionReference _userBodyProfileCollection = FirebaseFirestore.instance.collection('user_body_profile');

class UserBodyProfileInput extends StatefulWidget {
  const UserBodyProfileInput({super.key});

  @override
  State<UserBodyProfileInput> createState() => _UserBodyprofileInputState();
}

class _UserBodyprofileInputState extends State<UserBodyProfileInput> {

  final logger = Logger(); // 로그 확인하기 위한 생성자

  final _formKey= GlobalKey<FormState>();
  // 회원가입 정보 [이름, 이메일, 패스워드, 휴대폰 번호] //
  final TextEditingController _name= TextEditingController();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  final TextEditingController _passwordConfirm= TextEditingController();
  final TextEditingController _phoneNum= TextEditingController();
  final TextEditingController _authNum= TextEditingController();

  //회원 신체 정보 [생년, 월, 일, 키, 몸무게, 골격근량, 체지방량, 왼팔 근육량, 오른팔 근육량, 왼다리 근육량, 오른다리 근육량, 몸통 근육량
  final TextEditingController _birthYear = TextEditingController();
  final TextEditingController _birthMonth = TextEditingController();
  final TextEditingController _birthDay = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _skeletalMuscleMass = TextEditingController();
  final TextEditingController _fatMass = TextEditingController();
  final TextEditingController _leftArmMuscleMass = TextEditingController();
  final TextEditingController _rightArmMuscleMass = TextEditingController();
  final TextEditingController _leftLegMuscleMass = TextEditingController();
  final TextEditingController _rightLegMuscleMass = TextEditingController();
  final TextEditingController _torsoMuscleMass = TextEditingController();

  late String verificationId; // 인증번호, 초기화는 인증번호를 발급받은 뒤에 해 주기 때문에 late

  // 회원가입 전, 체크해야 할 항목들 [인증번호 확인, 이메일 중복여부, 이메일 중복체크, 비밀번호 확인]
  bool isVerificationSuccessful = false;
  bool isEmailDuplicated = false;
  bool isEmailChecked = false;
  bool passwordMatch = true;



  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth 인스턴스 생성

  final FirebaseService firebaseService = FirebaseService(); // FirebaseService (FireStore 인스턴스 생성)

  Future<void> saveUserBodyProfile() async{
    try{
      int birthYear = int.parse(_birthYear.text);
      int birthMonth = int.parse(_birthMonth.text);
      int birthDay = int.parse(_birthDay.text);
      int height = int.parse(_heightController.text);
      int weight = int.parse(_weightController.text);
      int skeletalMuscleMass = int.parse(_skeletalMuscleMass.text);
      int fatMass = int.parse(_fatMass.text);
      int leftArmMuscleMass = int.parse(_leftArmMuscleMass.text);
      int rightArmMuscleMass = int.parse(_rightArmMuscleMass.text);
      int leftLegMuscleMass = int.parse(_leftLegMuscleMass.text);
      int rightLegMuscleMass = int.parse(_rightLegMuscleMass.text);
      int torsoMuscleMass = int.parse(_torsoMuscleMass.text);

      await _userBodyProfileCollection.add({
        'birthYear': birthYear,
        'birthMonth': birthMonth,
        'birthDay': birthDay,
        'height': height,
        'weight': weight,
        'skeletalMuscleMass': skeletalMuscleMass,
        'fatMass': fatMass,
        'leftArmMuscleMass': leftArmMuscleMass,
        'rightArmMuscleMass': rightArmMuscleMass,
        'leftLegMuscleMass': leftLegMuscleMass,
        'rightLegMuscleMass': rightLegMuscleMass,
        'torsoMuscleMass': torsoMuscleMass,
      });
      print('사용자 신체 정보가 Firestore에 저장되었습니다.');
    }catch(e){
      print('사용자 신체 정보 저장 중 오류 발생: $e');
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
                    '아래의 정보를 추가로 입력하시면\n'
                    '운동 루틴 추천을 받을 수 있습니다!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '생년',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '생년 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _birthYear,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '생년을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '월',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '월 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _birthMonth,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '월을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '일',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '일 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _birthDay,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '일을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.03),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '키 (cm)',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '숫자 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _heightController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '키를 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 100),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '몸무게 (kg)',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '숫자 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _weightController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '몸무게를 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                          ],
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
                              labelText: '골격근량 (kg)',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: '숫자 입력',
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
                          controller: _skeletalMuscleMass,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return '골격근량을 입력해 주세요.';
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
                              labelText: '체지방량(kg)',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: '숫자 입력',
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
                          controller: _fatMass,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return '체지방량을 입력하세요.';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '왼팔 근육량 (kg)',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '숫자 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _leftArmMuscleMass,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '왼팔 근육량을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 100),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '오른팔 근육량 (kg)',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '숫자 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _rightArmMuscleMass,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '오른팔 근육량을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '왼다리 근육량 (kg)',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '숫자 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _leftLegMuscleMass,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '왼다리 근육량을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 100),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: '오른다리 근육량 (kg)',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  hintText: '숫자 입력',
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                controller: _rightLegMuscleMass,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '오른다리 근육량을 입력해 주세요.';
                                  }
                                },
                              ),
                            ),
                          ],
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
                              labelText: '몸통 근육량 (kg)',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintText: '숫자 입력',
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
                          controller: _torsoMuscleMass,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return '몸통 근육량을 입력해 주세요.';
                            }
                          },
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
                          saveUserBodyProfile();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Result()));
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: Colors.white,
                            minimumSize: Size(size.width*0.3, size.height*0.1)
                        ),
                        child: const Text(
                          '입력완료',
                          style: TextStyle(
                              color:Colors.red
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Result()));
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: Colors.white,
                            minimumSize: Size(size.width*0.3, size.height*0.1)
                        ),
                        child: const Text(
                          '입력취소',
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