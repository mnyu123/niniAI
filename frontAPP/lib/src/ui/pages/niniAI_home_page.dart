import 'package:flutter/material.dart';
import '../widgets/niniAI_playback_bar.dart';

class niniAIHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('niniAI Music Player'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // TODO: 검색/필터 UI 연결
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 재생목록 영역 (예시: ListView)
          Expanded(
            child: ListView.builder(
              itemCount: 10, // 임시 데이터
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    'https://via.placeholder.com/50', // 유튜브 썸네일 대체 이미지
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text('Song Title ${index + 1}'),
                  subtitle: Text('Channel Name'),
                  onTap: () {
                    // TODO: 선택 시 상세 페이지 혹은 재생 처리
                  },
                );
              },
            ),
          ),
          // 하단 재생바 (미니 플레이어)
          niniAIPlaybackBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add),
        onPressed: () {
          // TODO: 플레이리스트 관리/추가 화면 연결
        },
      ),
    );
  }
}
