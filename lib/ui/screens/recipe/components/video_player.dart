import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerItem({required this.videoUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _RemoteVideo(videoUrl: videoUrl);
  }

}


class _RemoteVideo extends StatefulWidget {
  final String videoUrl;

  _RemoteVideo({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _RemoteVideoState createState() => _RemoteVideoState();
}

class _RemoteVideoState extends State<_RemoteVideo> {
  late VideoPlayerController _controller;
  late File file;
  late bool fetchVideoFromOnline = true;
  late bool attachedListener = false;

/*  Future<ClosedCaptionFile> _loadCaptions() async {
    final String fileContents = await DefaultAssetBundle.of(context)
        .loadString('assets/bumble_bee_captions.srt');
    return SubRipCaptionFile(fileContents);
  }*/

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initVideoController();
  }

  initVideoController(){
     _controller = fetchVideoFromOnline
        ? VideoPlayerController.network(
            widget.videoUrl,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          ) //url of video
        : VideoPlayerController.file(
            file,
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)
          );
       _controller.addListener(() {
         setState(() {});
       });
     _controller.setLooping(false);
     _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("FetchVideoFromOnline $fetchVideoFromOnline");
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 24),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                ClosedCaption(text: _controller.value.caption.text),
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 0,
          child:
          FloatingActionButton(
            elevation: 0,
            mini: true,
            onPressed: () => { _controller.value.isPlaying ? _controller.pause() : _controller.play()},
            child: Icon( _controller.value.isPlaying ? Icons.pause : Icons.play_arrow_rounded, size: 32,),
            backgroundColor: CustomColors.primaryColor,
            foregroundColor: Colors.white,
            shape: CircleBorder(
                side: BorderSide(
                    color: Colors.white, width: 2
                )
            ),),
        )
      ],
    );
  }

  void initPlatformState() async {
    print("Init Cache manager to cache the video");
    FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(widget.videoUrl);//url of video

    if (fileInfo != null && fileInfo.file == null) {

      setState(() {
        fetchVideoFromOnline = true;
      });
      initVideoController();
      file = await DefaultCacheManager().getSingleFile(widget.videoUrl); //here we provide the url of video to cache.
    } else if(fileInfo != null){
      print('cache ln: ${fileInfo.validTill}');
      setState(() {
        fetchVideoFromOnline = false;
        file = fileInfo.file;
      });
    }
  }

}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _playbackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /*AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
        ),*/
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _playbackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }


}
