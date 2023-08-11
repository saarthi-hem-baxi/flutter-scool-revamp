import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:students/helpers/network.dart';
import 'package:students/widgets/media/media_audio.dart';
import 'package:students/widgets/media/media_document.dart';
import 'package:students/widgets/media/media_image.dart';
import 'package:students/widgets/media/media_link.dart';
import 'package:students/widgets/media/media_pdf.dart';
import 'package:students/widgets/media/media_simulation.dart';
import 'package:students/widgets/media/media_utils.dart';
import 'package:students/widgets/media/media_video.dart';

class AppMediaWidget extends StatefulWidget {
  /// Please provide type when you know the type for reduce processing
  const AppMediaWidget({
    Key? key,
    required this.mediaUrl,
    this.thumbUrl,
    this.title,
    this.margin,
    this.customWidget,
    this.startTime,
    this.endTime,
    this.mediaType,
    this.size = const Size(87, 87),
    this.thumbnailBoxFit = BoxFit.cover,
    this.borderRadius,
    this.backgroundColor,
    this.thumbBoxDecoration,
    this.customIcon,
  }) : super(key: key);

  final String mediaUrl;
  final String? thumbUrl;
  final String? title;
  final EdgeInsets? margin;
  final Widget? customWidget;
  final MediaTypes? mediaType;
  final Size? size;
  final BoxFit? thumbnailBoxFit;
  final BorderRadius? borderRadius;

  /// use this parameter when you have video type
  final String? startTime;

  /// use this parameter when you have video type
  final String? endTime;

  /// when use thumbBoxDecoration then no need to use background color
  final Color? backgroundColor;

  /// if you want to use own custom box decoration for thumb container
  final BoxDecoration? thumbBoxDecoration;

  /// if you want to use own custom widget for display icon then use this parameters
  final Widget? customIcon;

  @override
  State<AppMediaWidget> createState() => _AppMediaWidgetState();
}

class _AppMediaWidgetState extends State<AppMediaWidget> {
  final APIClient apiClient = APIClient();

  final dio.Dio dioClient = dio.Dio();

  Widget? mediaWidget;

  bool isLoaded = false;

  Future<bool> getMediaContentType({required String contentItemType}) async {
    try {
      dio.Response response = await dioClient.get(
        widget.mediaUrl,
      );
      if (response.statusCode == 200) {
        List<String>? contentType = response.headers['content-type'];
        return (contentType ?? []).where((e) => e.startsWith(contentItemType)).toList().isNotEmpty;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<MediaTypes> getMediaTypeFromUrl() async {
    //return type when user have passed explicit
    if (widget.mediaType == MediaTypes.image) {
      return MediaTypes.image;
    } else if (widget.mediaType == MediaTypes.audio) {
      return MediaTypes.audio;
    } else if (widget.mediaType == MediaTypes.video) {
      return MediaTypes.video;
    } else if (widget.mediaType == MediaTypes.pdf) {
      return MediaTypes.pdf;
    } else if (widget.mediaType == MediaTypes.doc) {
      return MediaTypes.doc;
    } else if (widget.mediaType == MediaTypes.simulation) {
      return MediaTypes.simulation;
    } else if (widget.mediaType == MediaTypes.link) {
      return MediaTypes.link;
    }

    if (isYoutubeUrl(url: widget.mediaUrl)) {
      return MediaTypes.video;
    }
    if (isExtensionExistInUrl(url: widget.mediaUrl)) {
      String extension = widget.mediaUrl.split('.').last.toLowerCase();
      if (imageTypes.map((e) => e.toLowerCase()).contains(extension)) {
        return MediaTypes.image;
      } else if (audioTypes.map((e) => e.toLowerCase()).contains(extension)) {
        return MediaTypes.audio;
      } else if (videoTypes.map((e) => e.toLowerCase()).contains(extension)) {
        return MediaTypes.video;
      } else if (extension == 'pdf') {
        return MediaTypes.pdf;
      } else if (docTypes.map((e) => e.toLowerCase()).contains(extension)) {
        return MediaTypes.doc;
      } else {
        return MediaTypes.link;
      }
    } else {
      if (await getMediaContentType(contentItemType: 'image')) {
        return MediaTypes.image;
      } else if (await getMediaContentType(contentItemType: 'audio')) {
        return MediaTypes.audio;
      } else if (await getMediaContentType(contentItemType: 'video')) {
        return MediaTypes.video;
      } else if (await getMediaContentType(contentItemType: 'application/pdf')) {
        return MediaTypes.pdf;
      } else if (await getMediaContentType(contentItemType: 'application')) {
        return MediaTypes.link;
      } else {
        return MediaTypes.link;
      }
    }
  }

  Future getMediaWidget() async {
    if (await getMediaTypeFromUrl() == MediaTypes.image) {
      mediaWidget = MediaImage(
        thumbUrl: widget.thumbUrl ?? '',
        imageUrl: widget.mediaUrl,
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        fit: widget.thumbnailBoxFit,
      );
    } else if (await getMediaTypeFromUrl() == MediaTypes.audio) {
      mediaWidget = MediaAudio(
        audioUrl: widget.mediaUrl,
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        backgroundColor: widget.backgroundColor,
        customIcon: widget.customIcon,
        thumbBoxDecoration: widget.thumbBoxDecoration,
      );
    } else if (await getMediaTypeFromUrl() == MediaTypes.video) {
      mediaWidget = MediaVideo(
        videoUrl: widget.mediaUrl,
        thumbUrl: widget.thumbUrl ?? '',
        startTime: widget.startTime ?? '',
        endTime: widget.endTime ?? '',
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        thumbnailBoxFit: widget.thumbnailBoxFit,
        thumbBoxDecoration: widget.thumbBoxDecoration,
      );
    } else if (await getMediaTypeFromUrl() == MediaTypes.pdf) {
      mediaWidget = MediaPdf(
        pdfUrl: widget.mediaUrl,
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        backgroundColor: widget.backgroundColor,
        customIcon: widget.customIcon,
        thumbBoxDecoration: widget.thumbBoxDecoration,
      );
    } else if (await getMediaTypeFromUrl() == MediaTypes.doc) {
      mediaWidget = MediaDocument(
        docUrl: widget.mediaUrl,
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        backgroundColor: widget.backgroundColor,
        customIcon: widget.customIcon,
        thumbBoxDecoration: widget.thumbBoxDecoration,
      );
    } else if (await getMediaTypeFromUrl() == MediaTypes.simulation) {
      mediaWidget = MediaSimulation(
        link: widget.mediaUrl,
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        backgroundColor: widget.backgroundColor,
        customIcon: widget.customIcon,
        thumbBoxDecoration: widget.thumbBoxDecoration,
      );
    } else {
      mediaWidget = MediaLink(
        link: widget.mediaUrl,
        title: widget.title,
        margin: widget.margin,
        customWidget: widget.customWidget,
        size: widget.size,
        borderRadius: widget.borderRadius,
        backgroundColor: widget.backgroundColor,
        customIcon: widget.customIcon,
        thumbBoxDecoration: widget.thumbBoxDecoration,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMediaWidget(),
      builder: (context, snapshot) {
        return mediaWidget ?? const SizedBox();
      },
    );
  }
}
