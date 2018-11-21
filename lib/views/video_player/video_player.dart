import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<VideoPlayerScreen> {
  TextEditingController _textController;
  VideoPlayerController _videoController;
  bool _isLoading = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
        text: 'http://techslides.com/demos/sample-videos/small.mp4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Play'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: TextField(
                decoration: InputDecoration(hintText: 'Input video url...'),
                keyboardType: TextInputType.url,
                style: Theme.of(context).textTheme.title,
                maxLines: 1,
                controller: _textController,
              ),
            ),
            RaisedButton(
              child: const Text('Load video'),
              onPressed: () {
                initVideo();
              },
            ),
            _videoController == null
                ? Container()
                : !_videoController.value.initialized
                    ? Text("loading video...")
                    : Center(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: AspectRatio(
                            aspectRatio: _videoController.value.aspectRatio,
                            child: VideoPlayer(_videoController),
                          ),
                        ),
                      ),
            _videoController == null || !_videoController.value.initialized
                ? Container()
                : RaisedButton(
                    child: Text(
                        '${_videoController != null && _videoController.value.isPlaying ? 'Pause' : 'Play'} video'),
                    onPressed: () {
                      playPauseVideo();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void initVideo() {
    if (_videoController != null) {
      _videoController.dispose();
      _videoController = null;
    }
    setState(() {
      _isLoading = true;
    });
    _videoController = VideoPlayerController.network(_textController.text)
      ..addListener(() {
        final bool isPlaying = _videoController.value.isPlaying;
        final bool isLoading = !_videoController.value.initialized;
        if (isPlaying != _isPlaying || isLoading != _isLoading) {
          setState(() {
            _isLoading = isLoading;
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _isLoading = false;
          _isPlaying = false;
        });
      }).catchError((err) {
        print(err);
      });
  }

  void playPauseVideo() {
    if (_videoController == null) return;
    if (_videoController.value.isPlaying)
      _videoController.pause();
    else
      _videoController.play();
  }
}
