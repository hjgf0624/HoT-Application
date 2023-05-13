import 'package:flutter/material.dart';
import './result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final _formKey= GlobalKey<FormState>();
  TextEditingController _email= new TextEditingController();
  TextEditingController _password= new TextEditingController();

  void signINto(){
    Navigator.push(context,MaterialPageRoute(builder: ((context) => Result())));
  }

  Future<void> signin() async{

    try{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      print(_email);
    }catch(e)
    {  print(e);}

    Navigator.push(context,MaterialPageRoute(builder: ((context) => Result())));


  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: size.height*0.04,left: size.height*0.04,right: size.height*0.04,),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('로그인 페이지',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: size.height*0.04,),

                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(

                        labelText: '이메일',
                        hintText: '이메일을 입력하세요.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),

                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '이메일을 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.02,),
                  TextFormField(

                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(

                        labelText: '비밀번호',
                        hintText: '비밀번호를 입력하세요.',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),

                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return '비밀번호를 입력하세요.';
                      }
                    },
                  ),
                  SizedBox(height: size.height*0.03,),
                  InkWell(
                    onTap: () {

                        print('done');
                          if(_formKey.currentState!.validate()){
                            signINto();
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
                      child:Center(child: Text('로그인',
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