import 'package:flutter/material.dart';
import './result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey= GlobalKey<FormState>();
  TextEditingController _name= new TextEditingController();
  TextEditingController _email= new TextEditingController();
  TextEditingController _password= new TextEditingController();

  Future<void> signup() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text );
    }catch(e){print(e);}
    Navigator.push(context,MaterialPageRoute(builder: ((context) => Result())));
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: size.height*0.03,left: size.height*0.04,right: size.height*0.04,),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('회원가입 페이지',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: size.height*0.03,),
                  TextFormField(

                    decoration: InputDecoration(

                        labelText: '이름',
                        hintText: '이름을 입력하세요.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color:  Colors.blue,
                              width: 3,
                              // style: BorderStyle.solid
                            )
                        )
                    ),
                    controller: _name,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '이름을 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.02,),
                  TextFormField(

                    decoration: InputDecoration(

                        labelText: '이메일',
                        hintText: '이메일을 입력하세요.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                    controller: _email,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '이메일을 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.02,),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(

                        labelText: '비밀번호',
                        hintText: '비밀번호를 입력하세요.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                    controller: _password,
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '비밀번호를 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.03,),
                  InkWell(
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        signup();
                      }
                    },
                    child: Container(
                      width:size.width*0.9,
                      height: size.height*0.09,
                      decoration: BoxDecoration(
                          color:  Color.fromARGB(255, 4, 94, 251),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          )
                      ),
                      child:Center(child: Text('회원가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,

                        ),
                      )) ,
                    ),
                  )
                ],
              )),
        )
    );
  }
}