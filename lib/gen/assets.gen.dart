// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/award.png
  AssetGenImage get award => const AssetGenImage('assets/icons/award.png');

  /// File path: assets/icons/awards.svg
  String get awards => 'assets/icons/awards.svg';

  /// File path: assets/icons/internet.json
  String get internet => 'assets/icons/internet.json';

  /// File path: assets/icons/music.png
  AssetGenImage get music => const AssetGenImage('assets/icons/music.png');

  /// File path: assets/icons/question_mark.svg
  String get questionMark => 'assets/icons/question_mark.svg';

  /// File path: assets/icons/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/icons/settings.png');

  /// File path: assets/icons/videoAds.json
  String get videoAds => 'assets/icons/videoAds.json';

  /// File path: assets/icons/volume.png
  AssetGenImage get volume => const AssetGenImage('assets/icons/volume.png');

  /// List of all assets
  List<dynamic> get values => [
    award,
    awards,
    internet,
    music,
    questionMark,
    settings,
    videoAds,
    volume,
  ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/Sad Face (1).json
  String get sadFace1 => 'assets/lottie/Sad Face (1).json';

  /// File path: assets/lottie/brain.json
  String get brain => 'assets/lottie/brain.json';

  /// File path: assets/lottie/dancerMonkey.json
  String get dancerMonkey => 'assets/lottie/dancerMonkey.json';

  /// File path: assets/lottie/face.json
  String get face => 'assets/lottie/face.json';

  /// File path: assets/lottie/meditatingBrain.json
  String get meditatingBrain => 'assets/lottie/meditatingBrain.json';

  /// File path: assets/lottie/sad.json
  String get sad => 'assets/lottie/sad.json';

  /// List of all assets
  List<String> get values => [
    sadFace1,
    brain,
    dancerMonkey,
    face,
    meditatingBrain,
    sad,
  ];
}

class $AssetsMusicsGen {
  const $AssetsMusicsGen();

  /// File path: assets/musics/happypop.mp3
  String get happypop => 'assets/musics/happypop.mp3';

  /// File path: assets/musics/music.mp3
  String get music => 'assets/musics/music.mp3';

  /// File path: assets/musics/musicc.mp3
  String get musicc => 'assets/musics/musicc.mp3';

  /// List of all assets
  List<String> get values => [happypop, music, musicc];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/tr-TR.json
  String get trTR => 'assets/translations/tr-TR.json';

  /// List of all assets
  List<String> get values => [enUS, trTR];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsMusicsGen musics = $AssetsMusicsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
