import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPageScreen(),
    );
  }
}

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
                      '이주환',
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
                                      TextSpan(text: '177', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                  TextSpan(text: '71', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                      TextSpan(text: '38', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                      TextSpan(text: '8', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                      TextSpan(text: '4', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                      TextSpan(text: '10', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                      TextSpan(text: '4', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
                                      TextSpan(text: '10', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
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
    );
  }
}