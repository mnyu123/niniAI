// 파일: lib/src/ui/pages/niniAI_home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../models/niniAI_video_model.dart';
import '../../providers/video_provider.dart';
import '../../providers/player_provider.dart';
import '../widgets/niniAI_playback_bar.dart';

class niniAIHomePage extends StatefulWidget {
  const niniAIHomePage({super.key});

  @override
  State<niniAIHomePage> createState() => _niniAIHomePageState();
}

class _niniAIHomePageState extends State<niniAIHomePage> {
  @override
  void initState() {
    super.initState();
    // 첫 빌드 후 비디오 목록 로딩
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      final VideoProvider vp = Provider.of<VideoProvider>(context, listen: false);
      vp.fetchVideos(page: 0, size: 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PlayerProvider player = context.watch<PlayerProvider>(); // 재생바 표시용

    return Scaffold(
      appBar: AppBar(
        title: const Text('niniAI Music Player'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 검색/필터 UI 연결
            },
            tooltip: '검색',
          ),
        ],
      ),
      body: Consumer<VideoProvider>(
        builder: (BuildContext context, VideoProvider videoProvider, Widget? child) {
          if (videoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (videoProvider.errorMessage != null) {
            return Center(child: Text(videoProvider.errorMessage!));
          }
          if (videoProvider.videos.isEmpty) {
            return const Center(child: Text('No videos available'));
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: videoProvider.videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final NiniaIVideo video = videoProvider.videos[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
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
                                // 전역 재생 상태 로드(FullScreen/재생바에서 동일 상태 사용)
                                context.read<PlayerProvider>().load(video);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 하단 재생바: 전역 상태를 구독해 현재 곡 표시
              niniAIPlaybackBar(
                currentVideo: player.currentVideo,
                onPrevious: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('이전 곡')),
                  );
                },
                onNext: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('다음 곡')),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '플레이리스트 추가',
        onPressed: () {
          // TODO: 플레이리스트 관리/추가 화면 연결
        },
        child: const Icon(Icons.playlist_add),
      ),
    );
  }
}