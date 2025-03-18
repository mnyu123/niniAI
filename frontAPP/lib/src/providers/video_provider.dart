// 파일: lib/src/providers/video_provider.dart

import 'package:flutter/material.dart';

import '../models/niniAI_video_model.dart';
import '../services/niniAI_youtube_service.dart';

class VideoProvider extends ChangeNotifier {
  List<NiniaIVideo> _videos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<NiniaIVideo> get videos => _videos;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  final NiniaIYtService _service = NiniaIYtService();

  Future<void> fetchVideos(
      {int page = 0, int size = 10, String? channel}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedVideos =
          await _service.fetchVideos(page: page, size: size, channel: channel);
      _videos = fetchedVideos;
    } catch (error) {
      _errorMessage = "동영상을 불러오는데 문제가 발생했습니다. 나중에 다시 시도해주세요.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
