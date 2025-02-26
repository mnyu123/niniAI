import 'package:flutter/material.dart';
import '../../models/niniAI_video_model.dart';
import '../../services/niniAI_youtube_service.dart';
import '../widgets/niniAI_playback_bar.dart';

class niniAIHomePage extends StatefulWidget {
  @override
  _niniAIHomePageState createState() => _niniAIHomePageState();
}

class _niniAIHomePageState extends State<niniAIHomePage> {
  final NiniaIYtService _service = NiniaIYtService();
  Future<List<NiniaIVideo>>? _futureVideos;
  NiniaIVideo? _currentVideo;

  @override
  void initState() {
    super.initState();
    // 3개의 곡만 불러오도록 설정
    _futureVideos = _service.fetchVideos(page: 0, size: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('niniAI Music Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색/필터 UI 연결
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<NiniaIVideo>>(
              future: _futureVideos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else if (!snapshot.hasData || snapshot.data!.isEmpty)
                  return Center(child: Text('No videos available'));
                else {
                  List<NiniaIVideo> videos = snapshot.data!;
                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      NiniaIVideo video = videos[index];
                      return ListTile(
                        leading: Image.network(
                          video.thumbnailUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(video.title),
                        subtitle: Text(video.channelName),
                        onTap: () {
                          setState(() {
                            _currentVideo = video;
                          });
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          // 하단 재생바 위젯에 선택된 영상 정보를 전달
          niniAIPlaybackBar(currentVideo: _currentVideo),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add),
        onPressed: () {
          // 플레이리스트 관리/추가 화면 연결
        },
      ),
    );
  }
}