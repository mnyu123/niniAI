import 'package:flutter/material.dart';
import 'package:niniaifrontapp/src/providers/player_provider.dart';
import 'package:provider/provider.dart';
import '../pages/niniAI_full_screen_player_page.dart';

class MusicPlaybackBar extends StatelessWidget {
  const MusicPlaybackBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        final video = playerProvider.currentVideo;
        final controller = playerProvider.controller;
        final isPlaying = controller?.value.isPlaying ?? false;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (
                  context) => const FullScreenPlayerPage()),
            );
          },
          child: Container(
            color: Colors.grey[200],
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // 썸네일
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: (video != null)
                        ? DecorationImage(
                      image: NetworkImage(video.thumbnailUrl),
                      fit: BoxFit.cover,
                    )
                        : null,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                // 타이틀
                Expanded(
                  child: Text(
                    video != null ? '재생중: ${video.title}' : 'No video playing',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // 이전
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("이전 곡 (미구현)")),
                    );
                  },
                  tooltip: "이전 곡",
                ),
                // 재생/일시정지
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (controller != null) {
                      isPlaying ? playerProvider.pause() : playerProvider
                          .play();
                    }
                  },
                  tooltip: "재생/일시정지",
                ),
                // 다음
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("다음 곡 (미구현)")),
                    );
                  },
                  tooltip: "다음 곡",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}