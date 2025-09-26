import 'package:flutter/foundation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/niniAI_video_model.dart'; // NiniaIVideo 정의 경로

class PlayerProvider extends ChangeNotifier {
  YoutubePlayerController? _controller;
  NiniaIVideo? _currentVideo;

  YoutubePlayerController? get controller => _controller;
  NiniaIVideo? get currentVideo => _currentVideo;

  /// 새 영상 로드(+ 자동재생)
  void load(NiniaIVideo video) {
    _currentVideo = video;

    // 기존 컨트롤러 정리
    _controller?.pause();
    _controller?.dispose();

    _controller = YoutubePlayerController(
      initialVideoId: video.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    notifyListeners();
  }

  void play() {
    _controller?.play();
    notifyListeners();
  }

  void pause() {
    _controller?.pause();
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
