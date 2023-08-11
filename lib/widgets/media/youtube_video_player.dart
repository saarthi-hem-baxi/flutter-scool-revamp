import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students/widgets/loading_spinner.dart';
import 'package:students/widgets/media/media_utils.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  const YoutubeVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.startTime,
    required this.endTime,
    this.isActionBar = true,
    this.autoPlay = false,
  }) : super(key: key);

  final String videoUrl;
  final String startTime;
  final String endTime;
  final bool? isActionBar;
  final bool? autoPlay;

  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController? _controller;
  Duration? totalVideoDuration;

  bool isBack = true;
  bool isEndBack = true;

  bool _isPlayerReady = false;

  String? videoId;
  Timer? timer;

  Duration getStartTime() {
    if (widget.startTime == '') {
      return const Duration(minutes: 0, seconds: 0);
    } else if (widget.startTime.split(':').first == 'null' && widget.startTime.split(':').last == 'null') {
      return const Duration(minutes: 0, seconds: 0);
    } else if (widget.startTime.split(':').first == 'null' && widget.startTime.split(':').last != 'null') {
      return Duration(minutes: 0, seconds: int.parse(widget.startTime.split(':').last));
    } else if (widget.startTime.split(':').first != 'null' && widget.startTime.split(':').last != 'null') {
      return Duration(minutes: int.parse(widget.startTime.split(':').first), seconds: int.parse(widget.startTime.split(':').last));
    }
    return const Duration(minutes: 0, seconds: 0);
  }

  Duration getEndTime(Duration? totalTime) {
    if (widget.endTime.split(':').first == 'null' && widget.endTime.split(':').last == 'null' || widget.endTime == '') {
      return Duration(minutes: 0, seconds: totalTime?.inSeconds ?? 0);
    } else if (widget.endTime.split(':').first == 'null' && widget.endTime.split(':').last != 'null') {
      return Duration(minutes: 0, seconds: int.parse(widget.endTime.split(':').last));
    } else if (widget.endTime.split(':').first != 'null' && widget.endTime.split(':').last != 'null') {
      return Duration(minutes: int.parse(widget.endTime.split(':').first), seconds: int.parse(widget.endTime.split(':').last));
    } else {
      return const Duration(minutes: 0, seconds: 0);
    }
  }

  @override
  void initState() {
    super.initState();

    var yt = YoutubeExplode();
    var initialVideoId = getYoutubeVideoId(Uri.decodeFull(widget.videoUrl));
    yt.videos.get('https://www.youtube.com/watch?v=$initialVideoId').then((value) {
      Duration duration = value.duration ?? const Duration();
      if (mounted) {
        setState(() {
          totalVideoDuration = duration;
        });
      }

      // _prepareVideoStartEndTime();
      _controller = YoutubePlayerController(
        params: const YoutubePlayerParams(
          showControls: true,
          mute: false,
          showFullscreenButton: true,
          loop: false,
        ),
      )
        ..onInit = () {
          _controller?.loadVideoById(
              videoId: initialVideoId,
              startSeconds: getStartTime().inSeconds.toDouble(),
              endSeconds: getEndTime(totalVideoDuration).inSeconds.toDouble());
        }
        ..onFullscreenChange = (isFullScreen) {
          debugPrint('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
          if (isFullScreen) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          }
        }
        ..listen((event) {
          if (event.playerState == PlayerState.playing) {
            if (timer != null || timer?.isActive == true) {
              timer?.cancel();
            }
            timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              _controller?.currentTime.then((currentTimeInSec) {
                if (currentTimeInSec.ceil() == duration.inSeconds) {
                  backToEndScreen(); // when the video completed automatically back to screen
                  timer.cancel();
                }

                if (getEndTime(totalVideoDuration).inSeconds != duration.inSeconds) {
                  if (currentTimeInSec.ceil() == getEndTime(totalVideoDuration).inSeconds) {
                    backToScreen(); // when then end time is equaly to db time back to screen
                    timer.cancel();
                  }
                }
              });
            });
          }

          if (event.playerState == PlayerState.paused) {
            timer?.cancel();
          }
        });

      setState(() {
        _isPlayerReady = true;
      });
    });
  }

  void backToScreen() {
    if (isEndBack) {
      Navigator.pop(context);
    }
    setState(() {
      isEndBack = false;
    });
  }

  void backToEndScreen() {
    if (isBack) {
      Navigator.pop(context);
    }
    setState(() {
      isBack = false;
    });
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller?.pauseVideo();
    timer?.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.close();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const player = YoutubePlayerIFrame();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: widget.isActionBar! ? true : false,
      ),
      body: Container(
        color: Colors.black,
        child: !_isPlayerReady
            ? const Center(
                child: LoadingSpinner(),
              )
            : Center(
                child: YoutubePlayerScaffold(
                  // Passing controller to widgets below.
                  controller: _controller!,
                  aspectRatio: 16 / 9,
                  builder: (context, player) {
                    return Center(
                      child: Stack(
                        children: [
                          player,
                          Positioned.fill(
                            child: YoutubeValueBuilder(
                              controller: _controller,
                              builder: (context, value) {
                                return AnimatedCrossFade(
                                  firstChild: const SizedBox.shrink(),
                                  secondChild: Material(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            YoutubePlayerController.getThumbnail(
                                              videoId: _controller?.metadata.videoId ?? '',
                                              quality: ThumbnailQuality.medium,
                                            ),
                                          ),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      child: const Center(
                                        child: LoadingSpinner(),
                                      ),
                                    ),
                                  ),
                                  crossFadeState: value.playerState != PlayerState.cued ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 300),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
