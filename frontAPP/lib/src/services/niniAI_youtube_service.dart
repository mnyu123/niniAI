import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/niniAI_video_model.dart';
import 'dart:convert' show utf8;

class NiniaIYtService {
  // 에뮬레이터에서 호스트 머신의 localhost에 접근할 때는 10.0.2.2 사용
  final String baseUrl = "http://10.0.2.2:8081";

  Future<List<NiniaIVideo>> fetchVideos({int page = 0, int size = 10, String? channel}) async {
    String url = "$baseUrl/niniai_videos?page=$page&size=$size";
    if (channel != null && channel.isNotEmpty) {
      url += "&channel=$channel";
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // 한글 깨짐 문제 해결: response.body 대신 response.bodyBytes를 UTF-8로 디코딩
      List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      return jsonList.map((jsonItem) => NiniaIVideo.fromJson(jsonItem)).toList();
    } else {
      throw Exception("[니니AI]: ${response.statusCode}");
    }
  }
}
