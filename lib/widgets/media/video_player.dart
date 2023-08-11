// ignore_for_file: must_be_immutable, empty_catches

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:students/widgets/loading_spinner.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

bool _isFullScreen = false;
bool isOverlayVisible = false;
int nowPlaying = 0;

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String startTime;
  final String endTime;
  bool? isActionBar;
  final bool isfromLocal;
  bool? showControls = true;

  CustomVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.startTime,
    required this.endTime,
    this.isfromLocal = false,
    this.isActionBar = true,
    this.showControls = true,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  var isFromLocal = false;
  String introVideoUrl = '';
  var isCheckComplete = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        key: const ValueKey<String>('home_page'),
        child: isCheckComplete
            ? RemoteVideoPlayer(
                videoUrl: introVideoUrl,
                startTime: widget.startTime,
                endTime: widget.endTime,
                isActionBar: widget.isActionBar,
                isfromLocal: isFromLocal,
                showControls: widget.showControls,
              )
            : const Center(
                child: LoadingSpinner(),
              ),
      ),
    );
  }

  Future _saveVideo(String url) async {
    http.Response r = await http.head(Uri.parse(url));
    var urlVideoSize = double.parse(r.headers['content-length'].toString()) / (1024 * 1024);

    var appDocDir = await getTemporaryDirectory();
    String fullPath = appDocDir.path + '/' + (url.split('/').isNotEmpty ? url.split('/')[url.split('/').length - 1].replaceAll('%20', '') : '');
    bool fileExists = await File(fullPath).exists();
    if (fileExists && urlVideoSize == File(fullPath).lengthSync() / (1024 * 1024)) {}
    if (!fileExists) {
      try {
        if (await getDiskSpaceInfo(urlVideoSize)) {
          setState(() {
            isFromLocal = false;
            introVideoUrl = url;
            isCheckComplete = true;
          });
          await Dio().download(url, fullPath, onReceiveProgress: (received, total) {
            if (total != -1) {}
          });
        } else {
          setState(() {
            isFromLocal = false;
            introVideoUrl = url;
            isCheckComplete = true;
          });
        }
        // ignore: unused_catch_clause
      } on DioError catch (e) {}
    } else {
      if (urlVideoSize == File(fullPath).lengthSync() / (1024 * 1024)) {
        setState(() {
          isFromLocal = true;
          introVideoUrl = fullPath;
          isCheckComplete = true;
        });
      } else {
        //File(fullPath).delete();
        setState(() {
          isFromLocal = false;
          introVideoUrl = url;
          isCheckComplete = true;
        });
      }
    }
  }

  Future<bool> getDiskSpaceInfo(double urlVideoSize) async {
    var space = await DiskSpace.getFreeDiskSpace;
    if (urlVideoSize < space!) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    introVideoUrl = widget.videoUrl;

    _saveVideo(introVideoUrl);
  }
}

class RemoteVideoPlayer extends StatefulWidget {
  RemoteVideoPlayer({
    Key? key,
    required this.videoUrl,
    required this.startTime,
    required this.endTime,
    this.isfromLocal = false,
    this.isActionBar = true,
    required this.showControls,
  }) : super(key: key);
  final String videoUrl;
  final String startTime;
  final String endTime;
  final bool isfromLocal;
  bool? isActionBar;
  final bool? showControls;

  @override
  _RemoteVideoPlayerState createState() => _RemoteVideoPlayerState();
}

class _RemoteVideoPlayerState extends State<RemoteVideoPlayer> {
  late VideoPlayerController _controller;

  // ignore: unused_field
  late double _origVolume;
  bool startedPlaying = false;

  // ignore: unused_field
  bool _isPlayerReady = false;

  int startTime = 0;
  int? endTime;
  var isVideoPlayerShow = true;

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  Future playVideo() async {
    if (widget.isfromLocal) {
      _controller = VideoPlayerController.file(
        File(widget.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
    } else {
      _controller = VideoPlayerController.network(
        widget.videoUrl,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
    }

    _controller.initialize().then((value) => {
          _controller.addListener(() {
            //custom Listner
            if (_controller.value.isPlaying || _controller.value.duration == _controller.value.position) {
              setState(() {
                if (!_controller.value.isPlaying && _controller.value.isInitialized && (_controller.value.duration == _controller.value.position)) {
                  //checking the duration and position every time
                  //Video Completed//
                  //print("videoComplete===$isVideoComplete");

                  Wakelock.disable();
                  Get.back();
                  isVideoPlayerShow = false;
                  _controller.dispose();
                  if (mounted) {
                    setState(() {});
                  }
                }
              });
            }
          })
        });

    _controller.setLooping(false);

    _controller.play();
    Wakelock.enable();
    _isPlayerReady = true;
    _controller.addListener(() {
      // setState(() {
      // print('_controller.value.position====${_controller.value.position}');
      // print('_controller.value.duration====${_controller.value.duration.inSeconds - 1}');
      // if (_controller.value.position.inSeconds == _controller.value.duration.inSeconds-1) {
      //   _controller.pause();
      //   print('video End');
      //   Navigator.pop(context);
      // }
      // });
    }); //addListener {}
    setState(() {});
  }

  @override
  void dispose() {
    Wakelock.disable();
    isVideoPlayerShow = false;
    if (_controller.value.isPlaying) {
      _controller.pause();
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _origVolume = _controller.value.volume;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _isFullScreen
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              automaticallyImplyLeading: widget.isActionBar ?? false ? true : false,
            ),
      body: Column(
        children: <Widget>[
          isVideoPlayerShow
              ? Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: _isFullScreen ? const EdgeInsets.all(0) : const EdgeInsets.only(bottom: 20),
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.loose,
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: VideoPlayer(_controller),
                          )),
                          ClosedCaption(text: _controller.value.caption.text),
                          (widget.showControls ?? false)
                              ? VideoProgressIndicator(_controller, allowScrubbing: true, padding: const EdgeInsets.symmetric(vertical: 10))
                              : const SizedBox(),
                          _ControlsOverlay(controller: _controller),
                          isOverlayVisible ? VideoOverlay(controller: _controller) : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller}) : super(key: key);

  // ignore: unused_field
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  Future setToolbarVisibility() async {
    setState(() {
      isOverlayVisible = !isOverlayVisible;
    });
    Future.delayed(
        const Duration(seconds: 10),
        () => {
              if (isOverlayVisible)
                {
                  // setState(() {
                  isOverlayVisible = false
                  // })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setToolbarVisibility();
          },
        ),
      ],
    );
  }
}

class VideoOverlay extends StatefulWidget {
  const VideoOverlay({
    Key? key,
    required this.controller, //required this.setSpeed
  }) : super(key: key);
  final VideoPlayerController controller;

  //final Function setSpeed;

  @override
  State<VideoOverlay> createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<VideoOverlay> {
  final TextStyle _style = const TextStyle(fontSize: 16, color: Colors.white);
  late Duration currentDuration;
  late Duration totalDuration;
  String startText = '';
  double sliderPosition = 0.0;
  double sliderTotal = 0.0;

  @override
  void initState() {
    super.initState();
    currentDuration = const Duration(seconds: 0);
    totalDuration = const Duration(seconds: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) => {_getData()});
  }

  Future<void> _getData() async {
    // ignore: unnecessary_null_comparison
    if (widget.controller != null) {
      currentDuration = await widget.controller.position ?? const Duration(seconds: 0);
      totalDuration = widget.controller.value.duration;
      if (widget.controller.value.isPlaying) {
        startText = ((currentDuration.inSeconds / totalDuration.inSeconds) * 100).round().toString() + ' %';
      }
      sliderPosition = currentDuration.inSeconds.toDouble();
      sliderTotal = totalDuration.inSeconds.toDouble();

      setState(() {});
    }
  }

  Future showStatusBar() {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  Future hideStatusBar() {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  String _prepareTime(Duration time) {
    return '${(Duration(seconds: time.inSeconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return Positioned(
        bottom: 0,
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${_prepareTime(currentDuration)}/${_prepareTime(totalDuration)}', style: _style),
              IconButton(
                onPressed: () {
                  if (widget.controller.value.isPlaying) {
                    widget.controller.pause();
                  } else {
                    widget.controller.play();
                  }
                  setState(() {});
                },
                icon: (widget.controller.value.isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)),
                color: Colors.white,
              ),
              IconButton(
                  onPressed: () {
                    _isFullScreen = !_isFullScreen;
                    if (_isFullScreen) {
                      hideStatusBar();
                      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                    } else {
                      showStatusBar();
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                    }
                    setState(() {});
                  },
                  icon: _isFullScreen
                      ? const Icon(Icons.fullscreen_exit, color: Colors.white)
                      : const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                        ))
            ],
          ),
        ));
  }
}
