import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAssetsPage extends StatefulWidget {
  const VideoAssetsPage({super.key});

  @override
  State<VideoAssetsPage> createState() => _VideoAssetsPageState();
}

class _VideoAssetsPageState extends State<VideoAssetsPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _resInitializeVideoPlayer;
  bool _isPlaying = false;
  bool _isFinished = true;

  Future<void> _initializeVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play(); // reproducir el vídeo al cargar
  }

  void _play() {
    _videoPlayerController.play();
  }

  void _pause() {
    _videoPlayerController.pause();
  }

  void _stop() {
    _videoPlayerController.pause();
    _videoPlayerController.seekTo(.zero);
  }

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/steamboat_willie.mp4', // ruta al video de los assests
    );
    // _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(() {
      bool isPlaying = _videoPlayerController.value.isPlaying;
      bool isFinished = _videoPlayerController.value.position >= _videoPlayerController.value.duration;

      if (isFinished != _isFinished) {
        _videoPlayerController.seekTo(.zero);
      }

      if (isPlaying != _isPlaying || isFinished != _isFinished) {
        setState(() {
          _isPlaying = isPlaying;
          _isFinished = isFinished;
        });
      }
    });

    _resInitializeVideoPlayer = _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Vídeo (assets)'),
      ),
      body: FutureBuilder(
        future: _resInitializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == .done) {
            // terminado
            if (snapshot.hasError) {
              // con error
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              // sin error
              return _buildVideo();
            }
          } else {
            // espera
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildVideo() {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        ),
        Row(
          mainAxisAlignment: .center,
          children: [
            if (!_isPlaying) IconButton(icon: Icon(Icons.play_arrow), onPressed: _play),
            if (_isPlaying) IconButton(icon: Icon(Icons.pause), onPressed: _pause),
            if (!_isFinished) IconButton(icon: Icon(Icons.stop), onPressed: _stop),
          ],
        ),
      ],
    );
  }
}
