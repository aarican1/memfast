// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsState {
  final bool isMusicPlaying;
  final bool isSoundPlaying;
  final bool? allowMusicPlay;
  final bool? allowSoundPlay;

  SettingsState({
 required  this.isMusicPlaying,
  required   this.isSoundPlaying,
this.allowMusicPlay,
   this.allowSoundPlay,
  });

  SettingsState copyWith({
    bool? isMusicPlaying,
    bool? isSoundPlaying,
    bool? allowMusicPlay,
    bool? allowSoundPlay,
  }) {
    return SettingsState(
      isMusicPlaying: isMusicPlaying ?? this.isMusicPlaying,
      isSoundPlaying: isSoundPlaying ?? this.isSoundPlaying,
      allowMusicPlay: allowMusicPlay ?? this.allowMusicPlay,
      allowSoundPlay: allowSoundPlay ?? this.allowSoundPlay,
    );
  }
}
