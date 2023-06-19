import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late ChewieController _chewieController;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    // 비디오 플레이어 컨트롤러를 초기화합니다.
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    // 컨트롤러를 해제합니다.
    _chewieController.dispose();
  }

  void _initializeVideoPlayer() {
    //VideoPlayerController 초기화
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    // ChewieController를 초기화합니다.
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      // 다른 ChewieController 설정들을 추가할 수 있습니다.
      // 자세한 설정들은 Chewie 패키지 문서를 참조하세요.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '운동 영상',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff181423),
      ),

      body: Center(
        //화면에 Chewie Widget 출력
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}