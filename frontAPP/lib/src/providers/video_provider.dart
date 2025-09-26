// 파일: lib/src/providers/video_provider.dart

import 'package:flutter/foundation.dart';
import 'package:niniaifrontapp/src/models/niniAI_video_model.dart';
import 'package:niniaifrontapp/src/services/niniAI_youtube_service.dart';


class VideoProvider extends ChangeNotifier {
  final List<NiniaIVideo> _videos = <NiniaIVideo>[];
  bool _isLoading = false;
  String? _errorMessage;

  List<NiniaIVideo> get videos => List<NiniaIVideo>.unmodifiable(_videos);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final NiniaIYtService _service;

  VideoProvider({NiniaIYtService? service}) : _service = service ?? NiniaIYtService();

  Future<void> fetchVideos({int page = 0, int size = 10, String? channel}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final List<NiniaIVideo> fetched =
      await _service.fetchVideos(page: page, size: size, channel: channel);

      _videos
        ..clear()
        ..addAll(fetched);
    } catch (error, stack) {
      _errorMessage = "동영상을 불러오는데 문제가 발생했습니다. 나중에 다시 시도해주세요.";
      if (kDebugMode) {
        // 디버깅용 로그
        // ignore: avoid_print
        print('[VideoProvider] fetchVideos error: $error\n$stack');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
