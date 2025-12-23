import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/google_ads/google_ads_state.dart';
import 'package:memfast/data/services/permission/permisson_service.dart';

class GoogleAdsCubit extends Cubit<GoogleAdsState> {
  GoogleAdsCubit() : super(const GoogleAdsState(showRewardedAd: 0)) {
    loadAd();
  }
  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;
  final PermissionService permissionService = PermissionService();

  Future<void> loadAd() async {
    await permissionService.requestAdvertisingId();
    if (state.adLoaded == true || state.adLoading == true) {
    } else {
      emit(state.copyWith(adLoading: true));
      String adUnitId = "ca-app-pub-7594703334228561/1928702834";

      if (Platform.isAndroid || !Platform.isIOS) {
        adUnitId = "ca-app-pub-7594703334228561/2544822530";
      } else {
        adUnitId = "ca-app-pub-7594703334228561/1928702834";
      }
      rewardedAd = null;
      await RewardedAd.load(
        adUnitId: adUnitId,
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

            if (numRewardedLoadAttempts < 3) {
              loadAd();
            } else {
              emit(
                state.copyWith(
                  errorMessage: LocaleKeys.somethingWentWrong.tr(),
                ),
              );
            }
          },
        ),
      );
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

  void showAd({
    required Function(AdWithoutView, RewardItem) onUserEarnedReward,
    required Function(RewardedAd) onAdDismissedFullScreenContent,
  }) {
    if (state.showRewardedAd < 3) {
      if (rewardedAd != null) {
        rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
        );
        rewardedAd!.show(onUserEarnedReward: onUserEarnedReward);
        emit(state.copyWith(showRewardedAd: state.showRewardedAd + 1));
        emit(state.copyWith(isAdShow: true, adLoaded: false, adLoading: false));
      } else {
        emit(state.copyWith(errorMessage: 'Ad not Found', isAdShow: false));
      }
    } else {
      emit(state.copyWith(rewardedAdLimit: true));
    }
  }
}
