import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memfast/google_ads/google_ads_state.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit() : super(const GoogleAdsState(showRewardedAd: 0)) {
    loadAd();
  }
  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

  void loadAd() {
    if (state.adLoaded == true || state.adLoading == true) {
    } else {
      emit(state.copyWith(
        adLoading: true,
      ));

      rewardedAd = null;
      RewardedAd.load(
          adUnitId: 'your adUnitID',
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              emit(state.copyWith(adLoading: false, adLoaded: true));

              rewardedAd = ad;
              numRewardedLoadAttempts = 0;
            },
            onAdFailedToLoad: (LoadAdError error) {
              emit(state.copyWith(adLoaded: false, adLoading: false));
              rewardedAd = null;
              numRewardedLoadAttempts += 1;

              if (numRewardedLoadAttempts < 2) {
                loadAd();
              } else {
                emit(state.copyWith(errorMessage: error.message));
              }
            },
          ));
    }
  }

  void errorMakeNull() {
    emit(state.copyWith(errorMessage: null));
  }

  bool getLoadedInfo() {
    return state.adLoaded ?? false;
  }

  bool getReward() {
    if (state.isGetReward != null) {
      return state.isGetReward!;
    } else {
      return false;
    }
  }

  void winReward() {
    emit(state.copyWith(isGetReward: true));
  }

  void showAd(
      {required Function(AdWithoutView, RewardItem) onUserEarnedReward,
      required Function(RewardedAd) onAdDismissedFullScreenContent}) {
    if (state.showRewardedAd < 2) {
      if (rewardedAd != null) {
        rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: onAdDismissedFullScreenContent);
        rewardedAd!.show(
          onUserEarnedReward: onUserEarnedReward,
        );
        emit(state.copyWith(showRewardedAd: state.showRewardedAd + 1));
        emit(state.copyWith(isAdShow: true, adLoaded: false, adLoading: false));
      } else {
        emit(state.copyWith(
          errorMessage: 'Ad not Found',
          isAdShow: false,
        ));
      }
    } else {
      emit(state.copyWith(rewardedAdLimit: true));
    }
  }
}
