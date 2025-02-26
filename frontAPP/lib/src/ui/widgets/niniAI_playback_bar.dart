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
          // 썸네일 표시
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
              child: Center(child: Text('Img', style: TextStyle(color: Colors.white))),
            ),
          ),
          SizedBox(width: 8),
          // 영상 정보 표시
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
          ),
          // 재생 버튼: 현재 선택된 영상이 있을 경우 VideoPlayerPage로 이동
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
          ),
          // 다음 곡 버튼
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
