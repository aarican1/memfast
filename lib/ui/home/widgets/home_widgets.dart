import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/ui/best_scores/best_scores_page.dart';
import 'package:memfast/ui/home/cubit/home_cubit.dart';
import 'package:memfast/ui/register/widgets/register_widgets.dart';
import 'package:memfast/ui/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/ui/select_level/page/select_level_page.dart';
import 'package:memfast/ui/settings/settings_page.dart';
import 'package:memfast/core/product/constants/color_contants.dart';

class LetsStartButton extends StatelessWidget {
  const LetsStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeConstants.fortyEight),
      child: InkWell(
        onTap: () {
          context.read<SelectLevelCubit>().choiceButtonColor();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SelectLevelPage();
              },
            ),
          );
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          height: SizeConstants.fiftySix,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstants.buttonBackgroundColor,
            borderRadius: BorderRadius.circular(SizeConstants.twentyFour),
          ),
          child: const Center(
            child: Icon(Icons.play_arrow, color: ColorConstants.textColor),
          ),
        ),
      ),
    );
  }
}

class NameText extends StatelessWidget {
  const NameText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: RegisterAppBarTitle());
  }
}

class BestScoresButton extends StatelessWidget {
  const BestScoresButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        context.read<HomeCubit>().selectionBestScore();
        context.read<HomeCubit>().personalScore();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const BestScoresPage();
            },
          ),
        );
      },
      icon: Image.asset(
        Assets.icons.award.path,
        width: SizeConstants.fiftySix,
        height: SizeConstants.fiftySix,
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SettingsPage();
            },
          ),
        );
      },
      icon: Image.asset(
        Assets.icons.settings.path,
        width: SizeConstants.fiftySix,
        height: SizeConstants.fiftySix,
      ),
    );
  }
}
