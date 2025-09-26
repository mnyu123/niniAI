import 'package:flutter/material.dart';
import 'package:niniaifrontapp/src/providers/player_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../providers/player_provider.dart';

class FullScreenPlayerPage extends StatelessWidget {
  const FullScreenPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        final video = playerProvider.currentVideo;
        final controller = playerProvider.controller;

        return Scaffold(
          appBar: AppBar(
            title: Text('재생중: ${video?.title ?? ""}'),
          ),
          body: Center(
            child: controller == null
                ? const Text('재생할 영상이 없습니다')
                : YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.blue,
                handleColor: Colors.blueAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}
