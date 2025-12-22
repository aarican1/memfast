import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:memfast/data/local_database/secure_storage.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/ui/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> with WidgetsBindingObserver {
  final AudioPlayer musicPlayer = AudioPlayer();
  final AudioPlayer buttonPlayer = AudioPlayer();

  SettingsCubit()
    : super(SettingsState(isMusicPlaying: false, isSoundPlaying: false)) {
    WidgetsBinding.instance.addObserver(this);

    initAsset();
  }

  Future<void> initAsset() async {
    musicPlayer.setVolume(1);
    musicPlayer.setLoopMode(LoopMode.all);
    buttonPlayer.setAsset(Assets.musics.happypop);
    buttonPlayer.setVolume(1);
  }

  Future<void> fetchAllows() async {
    bool? aMusic = await BoolSharedPreferences.readBool('allowMusicPlay');
    bool? aSound = await BoolSharedPreferences.readBool('allowSoundPlay');

    try {
      await musicPlayer.setAsset(Assets.musics.music);
    } catch (e) {
      return;
    }

    if (aMusic != null) {
      emit(state.copyWith(allowMusicPlay: aMusic));
      if (state.allowMusicPlay!) {
        manageMusic();
      } else {
        stopMusic();
      }
    } else {
      emit(state.copyWith(allowMusicPlay: true));
      manageMusic();
    }
    if (aSound != null) {
      emit(state.copyWith(allowSoundPlay: aSound));
    } else {
      emit(state.copyWith(allowSoundPlay: true));
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (state.allowMusicPlay!) {
      if (lifecycleState == AppLifecycleState.paused) {
        stopMusic();
        emit(state.copyWith(isMusicPlaying: false));
      } else if (lifecycleState == AppLifecycleState.resumed) {
        playMusic();
        emit(state.copyWith(isMusicPlaying: true));
      }
    }
  }

  void manageMusic() async {
    if (state.allowMusicPlay!) {
      playMusic();
      emit(state.copyWith(isMusicPlaying: true));
    } else {
      if (state.isMusicPlaying) {
        stopMusic();
      } else {}
    }
  }

  void manageSound() {
    if (state.allowSoundPlay!) {
      playSound();
    }
  }

  Future<void> setAllowMusic() async {
    emit(state.copyWith(allowMusicPlay: !(state.allowMusicPlay!)));
    await BoolSharedPreferences.writeBool(
      'allowMusicPlay',
      (state.allowMusicPlay!),
    );
    manageMusic();
  }

  Future<void> setAllowSound() async {
    emit(state.copyWith(allowSoundPlay: !(state.allowSoundPlay!)));
    await BoolSharedPreferences.writeBool(
      'allowSoundPlay',
      (state.allowSoundPlay!),
    );
  }

  void playMusic() async {
    emit(state.copyWith(isMusicPlaying: true));
    await musicPlayer.play();
  }

  void playSound() async {
    buttonPlayer.setVolume(1);
    buttonPlayer.seek(Duration.zero);
    await buttonPlayer.play();
    emit(state.copyWith(isSoundPlaying: true));
  }

  void stopMusic() {
    emit(state.copyWith(isMusicPlaying: false));
    musicPlayer.stop();
  }

  void stopSound() {
    buttonPlayer.stop();
  }
}
