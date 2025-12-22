import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/ui/network_change/bloc/network_change_cubit.dart';
import 'package:memfast/ui/network_change/bloc/network_change_state.dart';
import 'package:memfast/ui/splash/splash_view.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/data/services/network_change_manage/network_change_enum_extensions.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<NetworkChangeCubit, NetworkChangeState>(
        listener: (context, state) {
          if (state.networkChangeResults == NetworkChangeResults.on) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SplashView()),
            );
          }
        },
        child: const Center(child: BaseTextWidget(text: 'SomethingWentWrong')),
      ),
    );
  }
}
