class NiniaIVideo {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final DateTime uploadDate;
  final String channelId;
  final String channelName;
  final String? channelLogo;

  NiniaIVideo({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.uploadDate,
    required this.channelId,
    required this.channelName,
    this.channelLogo,
  });

  factory NiniaIVideo.fromJson(Map<String, dynamic> json) {
    return NiniaIVideo(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      uploadDate: DateTime.parse(json['uploadDate']),
      channelId: json['channelId'] as String,
      channelName: json['channelName'] as String,
      channelLogo: json['channelLogo'] as String?,
    );
  }
}
