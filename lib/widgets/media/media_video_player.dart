import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students/widgets/media/video_player.dart';
import 'package:students/widgets/media/youtube_video_player.dart';

class MediaVideoPlayer extends StatefulWidget {
  const MediaVideoPlayer({
    Key? key,
    required this.isYoutubeVideo,
    required this.videoUrl,
    this.startTime = '',
    this.endTime = '',
  }) : super(key: key);

  final bool isYoutubeVideo;
  final String videoUrl;
  final String startTime;
  final String endTime;

  @override
  State<MediaVideoPlayer> createState() => _MediaVideoPlayerState();
}

class _MediaVideoPlayerState extends State<MediaVideoPlayer> {
  String getFilteredUrl() {
    if (widget.videoUrl.contains('drive.google.com')) {
      return widget.videoUrl.replaceAll('file/d/', 'uc?export=download&id=').replaceAll('/view?usp=sharing', '').replaceAll('/view', '');
    }
    return widget.videoUrl;
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.black,
            child: widget.isYoutubeVideo
                ? YoutubeVideoPlayer(
                    videoUrl: widget.videoUrl,
                    startTime: widget.startTime,
                    endTime: widget.endTime,
                  )
                : CustomVideoPlayer(
                    videoUrl: getFilteredUrl(),
                    startTime: widget.startTime,
                    endTime: widget.endTime,
                  ),
          ),
        ),
      ),
    );
  }
}
