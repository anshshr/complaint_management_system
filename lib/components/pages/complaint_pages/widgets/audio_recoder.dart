import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';

class RecorderScreen extends StatefulWidget {
  @override
  _RecorderScreenState createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isRecording = false;
  bool _hasPermission = false;
  String _filePath = '';
  Timer? _timer;
  int _elapsedTime = 0;
  bool _isPlaying = false;
  List<String> _audioFiles = [];

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
    await _player.openPlayer();
    await _checkMicrophonePermission();
    _loadAudioFiles();
  }

  Future<void> _checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    setState(() {
      _hasPermission = status.isGranted;
    });

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Microphone permission is required.')),
      );
    }
  }

  Future<void> _startRecording() async {
    Directory tempDir = await getTemporaryDirectory();
    String path =
        '${tempDir.path}/recorded_audio_${DateTime.now().millisecondsSinceEpoch}.wav'; // Save as .wav
    _filePath = path;

    await _recorder.startRecorder(
      toFile: path,
      codec: Codec.pcm16WAV,
    );

    setState(() {
      _isRecording = true;
      _elapsedTime = 0;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    _timer?.cancel();
    _timer = null;
  }

  Future<void> _saveRecording() async {
    if (_filePath.isNotEmpty) {
      setState(() {
        _audioFiles.insert(0, _filePath);
      });

      if (_audioFiles.length > 3) {
        String removedFile = _audioFiles.removeLast();
        File(removedFile).deleteSync();
      }

      _filePath = '';
    }
  }

  Future<void> _playRecording(String filePath) async {
    if (filePath.isNotEmpty) {
      setState(() {
        _isPlaying = true;
      });

      await _player.startPlayer(
        fromURI: filePath,
        codec: Codec.pcm16WAV,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
    }
  }

  Future<void> _stopPlaying() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _loadAudioFiles() async {
    Directory tempDir = await getTemporaryDirectory();
    List<FileSystemEntity> files = tempDir.listSync();
    List<String> audioPaths = files
        .where((file) => file.path.endsWith('.wav'))
        .map((file) => file.path)
        .toList();
    setState(() {
      _audioFiles = audioPaths.reversed.take(3).toList(); // Limit to latest 3
    });
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Record Your Audio',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_hasPermission) ...[
              Icon(Icons.mic_off, color: Colors.red, size: 100),
              SizedBox(height: 20),
              Text('Please grant microphone permission to start recording.',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            ] else ...[
              Container(
                height: 200,
                width: 2000,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isRecording)
                      Lottie.asset(
                        'assets/animation/record.json',
                        height: 150,
                        width: 600,
                        repeat: true,
                      ),
                    _isRecording
                        ? SizedBox()
                        : Icon(
                            Icons.mic_none,
                            color: Colors.black,
                            size: 60,
                          ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                _isRecording
                    ? 'Recording: ${_elapsedTime}s'
                    : 'Recorder Stopped',
                style: TextStyle(fontSize: 22, color: Colors.blueAccent),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isRecording ? Colors.redAccent : Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
                child: Text(
                  _isRecording ? 'Stop Recording' : 'Start Recording',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              if (!_isRecording && _filePath.isNotEmpty) ...[
                ElevatedButton(
                  onPressed: _saveRecording,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'Save Recording',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ],
            SizedBox(height: 20),

            // List of Recent Recordings
            Expanded(
              child: _audioFiles.isEmpty
                  ? Center(child: Text('No recordings yet'))
                  : ListView.builder(
                      itemCount: _audioFiles.length,
                      itemBuilder: (context, index) {
                        String filePath = _audioFiles[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Icon(
                              Icons.audiotrack,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                            title: Text('Audio File ${index + 1}',
                                style: TextStyle(fontSize: 18)),
                            trailing:
                                Icon(Icons.play_arrow, color: Colors.green),
                            onTap: () => _isPlaying
                                ? _stopPlaying()
                                : _playRecording(filePath),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
