import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/ui/home/cubit/home_cubit.dart';
import 'package:memfast/ui/sign_up/widgets/register_widgets.dart';
import 'package:memfast/ui/select_level/cubit/select_level_cubit.dart';
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
          context.push(RouterPath.selectLevel.path);
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
            child: Icon(
              Icons.play_arrow,
              size: SizeConstants.thirtyTwo,
              color: ColorConstants.textColor,
            ),
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
        context.push(RouterPath.bestScores.path);
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
        context.push(RouterPath.settings.path);
      },
      icon: Image.asset(
        Assets.icons.settings.path,
        width: SizeConstants.fiftySix,
        height: SizeConstants.fiftySix,
      ),
    );
  }
}
