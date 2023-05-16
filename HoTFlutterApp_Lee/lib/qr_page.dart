import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerate extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Center(
              child: Text(
                'HoT',
                style: TextStyle(fontFamily: 'Prismakers', fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Center(
              child: Column(
                children: [
                  Text('ONE 휘트니스', style: TextStyle(color: Colors.white),),
                  Text('입장 QR 코드', style: TextStyle(color: Colors.white),),
                  QrImageView(
                    data: "1234567890",
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                  Text('만료일까지 27일 남았습니다.', style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('다른 헬스장 선택', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('주변 헬스장 검색', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}