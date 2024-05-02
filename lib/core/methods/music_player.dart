import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';



class AudioManager with WidgetsBindingObserver {
  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal() {
    WidgetsBinding.instance.addObserver(this);
  }

  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioPlayer buttonPlayer = AudioPlayer();
  bool isMusicPlaying = false;
  bool isSoundPlaying = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
   
    if (state == AppLifecycleState.paused) {
      pauseMusic();
    } else if (state == AppLifecycleState.resumed) {
      if (isMusicPlaying) {
        playMusic();
      }
    }
  }

  Future<void> playMusic() async {
    try {
      await audioPlayer.setAsset('lib/assets/musics/gamemusic-6082.mp3');
      await audioPlayer.setVolume(0.2);
      await audioPlayer.setLoopMode(LoopMode.all);
      await audioPlayer.play();
      isMusicPlaying = true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> pauseMusic() async {
    await audioPlayer.pause();
    isMusicPlaying = false;
  }

  Future<void> stopMusic() async {
    await audioPlayer.stop();
    isMusicPlaying = false;
  }

  Future<void> playSound() async {
    try {
      await buttonPlayer.setAsset('lib/assets/musics/happypop.mp3');
      await buttonPlayer.setVolume(1);
      await buttonPlayer.seek(Duration.zero);
      await buttonPlayer.play();
      isSoundPlaying = true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> pauseSound() async {
    await buttonPlayer.pause();
    isSoundPlaying = false;
  }

  Future<void> stopSound() async {
    await buttonPlayer.stop();
    isSoundPlaying = false;
  }
}
