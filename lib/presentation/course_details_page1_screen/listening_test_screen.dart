import 'dart:async';

import 'package:anandhu_s_application4/data/models/home/course_content_by_module_model.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ListeningTestScreen extends StatefulWidget {
  const ListeningTestScreen({
    super.key,
    this.examContents,
  });
  final List<Exam>? examContents;

  @override
  State<ListeningTestScreen> createState() => _ListeningTestScreenState();
}

class _ListeningTestScreenState extends State<ListeningTestScreen> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final url =
            '${HttpUrls.imgBaseUrl}${widget.examContents?[0].mainQuestion}';
        if (url.isNotEmpty) {
          await player.setSource(UrlSource(url));
          await player.resume();
        }
      } catch (e) {
        print('Error setting audio source: $e');
        // Handle error (e.g., show a message to the user)
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.examContents?[0].fileName ?? 'Listening Test'),
      ),
      body: SfPdfViewer.network(
          '${HttpUrls.imgBaseUrl}${widget.examContents?[0].supportingDocumentPath}'),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        child: PlayerWidget(player: player),
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText =>
      _duration?.toString().split('.').first ?? '00:00:00';
  String get _positionText =>
      _position?.toString().split('.').first ?? '00:00:00';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    _playerState = player.state;
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue.shade600;
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isPlaying)
            Container(
              width: 45,
              height: 45,
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF6A7487),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: IconButton(
                key: const Key('play_button'),
                onPressed: _isPlaying ? null : _play,
                iconSize: 28.0,
                icon: const Icon(Icons.play_arrow),
                color: Color(0xFFE3E7EE),
              ),
            ),
          if (_isPlaying)
            Container(
              width: 45,
              height: 45,
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF6A7487),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: IconButton(
                key: const Key('pause_button'),
                onPressed: _isPlaying ? _pause : null,
                iconSize: 28.0,
                icon: const Icon(Icons.pause),
                color: Color(0xFFE3E7EE),
              ),
            ),
          // if (_isPlaying || _isPaused)
          //   IconButton(
          //     key: const Key('stop_button'),
          //     onPressed: _isPlaying || _isPaused ? _stop : null,
          //     iconSize: 48.0,
          //     icon: const Icon(Icons.stop),
          //     color: color,
          //   ),
          Expanded(
            child: Slider(
              thumbColor: Color(0xFF6A7487),
              activeColor: const Color(0xFF6A7487),
              inactiveColor:  Color(0xFFE3E7EE),
              onChanged: (value) {
                final duration = _duration;
                if (duration == null) return;
                final position = value * duration.inMilliseconds;
                player.seek(Duration(milliseconds: position.round()));
              },
              value: (_position != null &&
                      _duration != null &&
                      _position!.inMilliseconds > 0 &&
                      _position!.inMilliseconds < _duration!.inMilliseconds)
                  ? _position!.inMilliseconds / _duration!.inMilliseconds
                  : 0.0,
            ),
          ),
          Container(
            width: 115,
            child: Text(
              _position != null
                  ? '$_positionText / $_durationText'
                  : _duration != null
                      ? _durationText
                      : '00:00:00',
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
          Container(
            width: 20,
            margin: EdgeInsets.only(right:15),
            child: PopupMenuButton(
              color: Colors.white,
              iconColor: Colors.grey.shade600,
              itemBuilder: (c) => [
                PopupMenuItem(
                  onTap: () => _changePlaybackSpeed(0.5),
                  child: Text(
                    '0.5x',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                PopupMenuItem(
                  onTap: () => _changePlaybackSpeed(1.0),
                  child: Text(
                    '1x',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                PopupMenuItem(
                  onTap: () => _changePlaybackSpeed(1.5),
                  child: Text(
                    '1.5x',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                PopupMenuItem(
                  onTap: () => _changePlaybackSpeed(2),
                  child: Text(
                    '2x',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ]);
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    try {
      await player.resume();
      setState(() => _playerState = PlayerState.playing);
    } catch (e) {
      print('Error during playback: $e');
      // Handle error
    }
  }

  Future<void> _pause() async {
    try {
      await player.pause();
      setState(() => _playerState = PlayerState.paused);
    } catch (e) {
      print('Error during pause: $e');
      // Handle error
    }
  }

  Future<void> _stop() async {
    try {
      await player.stop();
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    } catch (e) {
      print('Error during stop: $e');
      // Handle error
    }
  }

  _changePlaybackSpeed(double d) {
    player.setPlaybackRate(d);
  }
}
