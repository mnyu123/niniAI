// 파일: lib/src/ui/widgets/niniAI_playback_bar.dart

import 'package:flutter/material.dart';
import '../../models/niniAI_video_model.dart';
import '../pages/niniAI_video_player_page.dart';

class niniAIPlaybackBar extends StatelessWidget {
  final NiniaIVideo? currentVideo;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const niniAIPlaybackBar({Key? key, this.currentVideo, this.onPrevious, this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // 썸네일 영역
          Container(
            width: 50,
            height: 50,
            child: currentVideo != null
                ? Image.network(
              currentVideo!.thumbnailUrl,
              fit: BoxFit.cover,
            )
                : Container(
              color: Colors.blue,
              child: Center(
                child: Text('Img', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(width: 8),
          // 영상 정보 영역
          Expanded(
            child: currentVideo != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentVideo!.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(currentVideo!.channelName),
              ],
            )
                : Text('No video playing'),
          ),
          // 이전 곡 버튼
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: onPrevious,
            tooltip: "이전 곡",
          ),
          // 재생 버튼: 선택된 영상이 있을 경우 재생 페이지로 이동
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              if (currentVideo != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerPage(videoId: currentVideo!.videoId),
                  ),
                );
              }
            },
            tooltip: "재생",
          ),
          // 다음 곡 버튼
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: onNext,
            tooltip: "다음 곡",
          ),
        ],
      ),
    );
  }
}
