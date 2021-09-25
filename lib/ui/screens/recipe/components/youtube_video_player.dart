
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sizer/sizer.dart';
class CustomYoutubePlayer extends StatefulWidget {
  final String videoPlayer;
  const CustomYoutubePlayer({required this.videoPlayer});
  @override
  _CustomYoutubePlayerState createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoPlayer,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        aspectRatio: 16/9,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(widget.videoPlayer);
        },
      ),
      builder: (context, player){
        return  Container(
          //color: Colors.blue,
          padding: EdgeInsets.only(bottom: 24),
          child: player/*Stack(
            children: [
              player,
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
          ),*/
        );
      },
    );
  }

}