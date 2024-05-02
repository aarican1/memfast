import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/best_scores/best_scores_page.dart';


import 'package:memfast/pages/home/cubit/home_cubit.dart';
import 'package:memfast/pages/register/widgets/register_widgets.dart';
import 'package:memfast/pages/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/pages/select_level/page/select_level_page.dart';
import 'package:memfast/pages/settings/settings_page.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';

class LetsStartButton extends StatelessWidget {
  const LetsStartButton({
    super.key,
    required this.mediaQCons,
  });

  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         context.read<SelectLevelCubit>().choiceButtonColor();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SelectLevelPage();
        }));
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height:
            mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.height) *
                0.064,
        width:
            mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                0.418,
        decoration: BoxDecoration(
          color: ColorConstants.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(mediaQCons
                  .getContantsMediaQueryData(MediaQueryContantsEnum.height) *
              0.064 *
              0.366),
        ),
        child: const Center(
            child: Icon(
          Icons.play_arrow,
          color: ColorConstants.textColor,
        )),
      ),
    );
  }
}

class NameText extends StatelessWidget {
  const NameText({
    super.key,
    required this.mediaQCons,
  });

  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 4,
      child: Padding(
        padding: EdgeInsets.only(
            top: mediaQCons.getContantsMediaQueryData(
                    MediaQueryContantsEnum.appbarPadding) *
                2),
        child: RegisterAppBarTitle(
            appBarFontSize: mediaQCons
                .getContantsMediaQueryData(MediaQueryContantsEnum.appBarFontSize),
            titleAppbarColor: ColorConstants.textColor),
      ),
    );
  }
}

class BestScoresButton extends StatelessWidget {
  const BestScoresButton({
    super.key,
    required this.mediaQCons,
  });

  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: mediaQCons
              .getContantsMediaQueryData(MediaQueryContantsEnum.appbarPadding),
          right:
              mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                  0.11),
      child: IconButton(
        onPressed: () {
          context.read<HomeCubit>().selectionBestScore();
          context.read<HomeCubit>().personalScore();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const BestScoresPage();
          }));
        },
        icon: Image.asset(
          'lib/assets/icons/award.png',
          width:
              mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                  0.10,
          height:
              mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                  0.10,
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.mediaQCons,
  });

  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: mediaQCons
              .getContantsMediaQueryData(MediaQueryContantsEnum.appbarPadding),
          left:
              mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                  0.11),
      child: IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const SettingsPage();
          }));
        },
        icon:Image.asset('lib/assets/icons/settings.png', width:
              mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                  0.10,
          height:
              mediaQCons.getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                  0.10,)  
      ),
    );
  }
}
