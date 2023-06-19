import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled2/UserSingleton.dart';
import 'package:untitled2/videotest.dart';
import 'firebase_options.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(
      debug: true
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: workoutDiaryPage(),
    )
  );
}

class workoutDiaryPage extends StatefulWidget{
  @override
  _workoutDiaryPageState createState() => _workoutDiaryPageState();
}

class _workoutDiaryPageState extends State<workoutDiaryPage>{
  EventList<Event> _markedDateMap = EventList(events: {});
  DateTime time = DateTime.now().add(Duration(hours: 9));
  final UserSingleton _userSingleton = UserSingleton();

  @override
  void initState() {
    super.initState();
    getAllDocumentNames();
  }

  static Widget _absentIcon(String day) => Container(
    decoration: BoxDecoration(
      color: Color(0xffD11507),
    ),
    child: Center(
      child: Text(
        day,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );

//컬렉션 안의 모든 문서의 이름 가져오기
  void getAllDocumentNames() async {
    //유저 uid 경로에 저장되어 있는 운동 정보 가져오기
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(_userSingleton.uid).get();

    //운동을 진행한 날짜를 _markedDateMap에 추가
    querySnapshot.docs.forEach((doc) {
      var date = DateFormat('yyyy_MM_dd').parse(doc.id);
      _markedDateMap.add(date, new Event(
        date: date,
        title: 'work',
        icon: _absentIcon(date.day.toString())
      ));
    });
    //화면 갱신을 위한 setState
    setState(() {
    });
  }

  late CalendarCarousel _calendarCarouselNoHeader;

  @override
  Widget build(BuildContext context) {
    String timeStr = DateFormat('yyyy_MM_dd').format(time);
    // getAllDocumentNames();

    _calendarCarouselNoHeader = CalendarCarousel<Event>(

      thisMonthDayBorderColor: Colors.grey,
      weekendTextStyle: TextStyle(color: Colors.red),
      dayPadding: 1,
      daysHaveCircularBorder: null,
      todayButtonColor: Color(0xff181423),
      weekdayTextStyle: TextStyle(
        color: Color(0xffD11507)
      ),
      headerTextStyle: TextStyle(
        color: Color(0xffD9D9D9)
      ),
      customDayBuilder: (
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        if (_markedDateMap
            ?.getEvents(day)
            ?.isNotEmpty ?? false) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xffD11507),
            ),
          );
        } else if(isPrevMonthDay || isNextMonthDay){
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,
            ),
          );
        }
        else {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xffD9D9D9),
            ),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(5),
            child: Text(
              day.day.toString(),
              style: TextStyle(fontSize: 10, color: Colors.black),
            )
          );
        }
      },
      headerMargin: const EdgeInsets.symmetric(vertical: 0),
      onDayPressed: (date, events){
        this.setState(() => time = date);
      },
    );

    return Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
      child: Column(
        children: <Widget>[
          const Expanded(
            flex: 10,
              child: Center(
                child: Text(
                  '[가슴 + 팔 운동] 할 차례입니다.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              )
          ),
          Expanded(
            flex: 45,
            child: Container(
              child: _calendarCarouselNoHeader,
            )
          ),
          Expanded(
            flex: 45,
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection(_userSingleton.uid).doc(timeStr).collection('workout').orderBy('time', descending: false).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final data = documents[index].data() as Map<String, dynamic>;
                    final workoutName = data['workoutName'] ?? '';
                    final count = data['count'] ?? '';
                    final videoID = data['videoID'] ?? '';
                    final uploadTime = data['time'] ?? '';
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: 'http://210.117.175.127:10060/video/$videoID',))
                        );
                      },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xff24223C),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          child:   Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset('assets/images/$workoutName.jpg', width: 100, height: 100,),
                                  )),
                              Expanded(
                                  flex: 70,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(workoutName,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                        Text(count + 'REPS',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          )
                        )
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
