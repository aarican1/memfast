// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GoogleAdsState extends Equatable {
  final bool? adLoading;
  final bool? adLoaded;
  final bool? isAdShow;
  final int showRewardedAd;
  final bool? isGetReward;
  final bool? rewardedAdLimit;
  final String? errorMessage;
  final bool? isOnUserEarnedReward;
  const GoogleAdsState({
    required this.showRewardedAd,
    this.adLoading,
    this.adLoaded,
    this.isAdShow,
    this.isGetReward,
    this.rewardedAdLimit,
    this.errorMessage,
    this.isOnUserEarnedReward,
  });

  @override
  List<Object?> get props => [
    showRewardedAd,
        rewardedAdLimit,
        adLoaded,
        isGetReward,
        isOnUserEarnedReward,
        adLoading,
        errorMessage,
        isAdShow
      ];

  GoogleAdsState copyWith({
    bool? adLoading,
    bool? adLoaded,
    bool? isAdShow,
    int? showRewardedAd,
    bool? isGetReward,
    bool? rewardedAdLimit,
    String? errorMessage,
    bool? isOnUserEarnedReward,
  }) {
    return GoogleAdsState(
      adLoading: adLoading ?? this.adLoading,
      adLoaded: adLoaded ?? this.adLoaded,
      isAdShow: isAdShow ?? this.isAdShow,
      showRewardedAd: showRewardedAd ?? this.showRewardedAd,
      isGetReward: isGetReward ?? this.isGetReward,
      rewardedAdLimit: rewardedAdLimit ?? this.rewardedAdLimit,
      errorMessage: errorMessage ?? this.errorMessage,
      isOnUserEarnedReward: isOnUserEarnedReward ?? this.isOnUserEarnedReward,
    );
  }
}
