import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;
  const VideoPlayerPage({super.key, required this.url});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final VideoPlayerController _vc;
  ChewieController? _chewie;

  @override
  void initState() {
    super.initState();
    _vc = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _init();
  }

  Future<void> _init() async {
    await _vc.initialize();
    await _vc.setVolume(1.0);
    _chewie = ChewieController(
      videoPlayerController: _vc,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,

      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primaryColor,
        handleColor: AppColors.whiteColor,
        backgroundColor: Colors.white24,
        bufferedColor: Colors.white38,
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _chewie?.dispose();
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Video', style: TextStyle(color: Colors.white)),
      ),
      body: _chewie == null
          ?  const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
          : SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(bottom: 16.h),
          child: Chewie(controller: _chewie!),
        ),
      ),
    );
  }
}