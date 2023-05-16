import 'package:flutter/material.dart';
import 'package:untitled2/qr_page.dart';
import 'package:untitled2/workoutDiary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BottomNavigationBarExampleApp());
}

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xff181423)),
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    QrGenerate(),
    MyApp(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff181423),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_deombell_grey.png', width: 30, height: 30,),
            activeIcon: Image.asset('assets/icons/icon_deombell_white.png', width: 30, height: 30,),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_home_grey.png', width: 25, height: 25,),
            activeIcon: Image.asset('assets/icons/icon_home_white.png', width: 25, height: 25,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_community_grey.png', width: 30, height: 30,),
            activeIcon: Image.asset('assets/icons/icon_community_white.png', width: 30, height: 30,),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_user_grey.png', width: 28, height: 28,),
            activeIcon: Image.asset('assets/icons/icon_user_white.png', width: 28, height: 28,),
            label: 'My'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}