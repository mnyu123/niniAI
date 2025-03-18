// 파일: lib/src/ui/pages/niniAI_home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../models/niniAI_video_model.dart';
import '../../providers/video_provider.dart';
import '../widgets/niniAI_playback_bar.dart';

class niniAIHomePage extends StatefulWidget {
  @override
  _niniAIHomePageState createState() => _niniAIHomePageState();
}

class _niniAIHomePageState extends State<niniAIHomePage> {
  NiniaIVideo? _currentVideo;

  @override
  void initState() {
    super.initState();
    // 위젯이 빌드된 후 Provider를 통해 데이터를 로드합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VideoProvider>(context, listen: false).fetchVideos(page: 0, size: 3);
    });
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
              // 검색/필터 UI 연결 (추후 구현)
            },
            tooltip: "검색",
          ),
        ],
      ),
      body: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) {
          if (videoProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (videoProvider.errorMessage != null) {
            return Center(child: Text(videoProvider.errorMessage!));
          } else if (videoProvider.videos.isEmpty) {
            return Center(child: Text('No videos available'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: videoProvider.videos.length,
                      itemBuilder: (context, index) {
                        final video = videoProvider.videos[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ListTile(
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
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // 하단 재생바: 버튼 클릭 시 스낵바 등 피드백 제공
                niniAIPlaybackBar(
                  currentVideo: _currentVideo,
                  onPrevious: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("이전 곡")),
                    );
                  },
                  onNext: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("다음 곡")),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add),
        onPressed: () {
          // 플레이리스트 관리/추가 화면 연결 (추후 구현)
        },
        tooltip: "플레이리스트 추가",
      ),
    );
  }
}
