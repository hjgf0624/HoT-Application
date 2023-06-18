import 'package:flutter/material.dart';
import 'package:untitled2/UserSingleton.dart';

import 'package:untitled2/UserBodyProfilePage.dart';


class MyPageScreen extends StatefulWidget{
  @override
  MyPageScreenState createState() => MyPageScreenState();
}

class MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    UserSingleton _userSingleton = UserSingleton();
    Size size=MediaQuery.of(context).size;
    Map? user_data = _userSingleton.user_data;
    print("mypage");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child:
      Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              color: Color(0xff181423),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Text(
                      user_data?['name'],
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.account_circle,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                    child:Center(
                        child: Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['height'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'cm', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('키', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        )
                    )
                ),
                Expanded(
                  flex: 1,
                  child:Center(
                    child: Column(
                      children: [
                        Text.rich(
                            TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: user_data?['weight'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                  TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                ]
                            )
                        ),
                        Text('몸무게', style: TextStyle(fontSize: 15, color: Colors.grey),),
                      ],
                    )
                  )
                ),
                Expanded(
                  flex: 1,
                    child:Center(
                        child: Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['skeletalMuscleMass'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('골격근량', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        )
                    )
                ),
                Expanded(
                  flex: 1,
                    child:Center(
                        child: Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['fatMass'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('체지방량', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              color: Color(0xff181423),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['leftArmMuscleMass'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('왼팔 근육량', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        ),
                        Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['leftLegMuscleMass'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('왼다리 근육량', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset('assets/images/body.png'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['rightArmMuscleMass'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('오른팔 근육량', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        ),
                        Column(
                          children: [
                            Text.rich(
                                TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: user_data?['rightLegMuscleMass'].toString(), style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                                      TextSpan(text: 'kg', style: TextStyle(fontSize: 15, color: Color(0xffD11507),))
                                    ]
                                )
                            ),
                            Text('오른다리 근육량', style: TextStyle(fontSize: 15, color: Colors.grey),),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: OutlinedButton(
                onPressed: (){
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => UserBodyProfileInput())
                  // ).then((value) => setState(() {}));
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserBodyProfileInput())
                  ).then((value) => setState(() {}));
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.white,
                    minimumSize: Size(size.width*0.3, size.height*0.05)
                ),
                child: const Text(
                  '수정하기',
                  style: TextStyle(
                      color:Colors.red
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
