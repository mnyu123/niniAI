import 'package:flutter/material.dart';

class niniAIPlaybackBar extends StatefulWidget {
  @override
  _niniAIPlaybackBarState createState() => _niniAIPlaybackBarState();
}

class _niniAIPlaybackBarState extends State<niniAIPlaybackBar> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // 채널/영상 썸네일 자리 (예시)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                'Img',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 8),
          // 현재 재생 중인 노래 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Song Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Channel Name'),
              ],
            ),
          ),
          // 재생 제어 버튼들
          IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: () {
              // TODO: 이전 곡으로 이동
            },
          ),
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: () {
              // TODO: 다음 곡으로 이동
            },
          ),
        ],
      ),
    );
  }
}
