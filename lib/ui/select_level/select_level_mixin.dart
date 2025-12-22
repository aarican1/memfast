part of 'select_level_view.dart';

mixin SelectLevelMixin on StatelessWidget {
  void listener(BuildContext context, SelectLevelState state) {
    if (state.errorMessage != null) {
      showDialog(
        context: context,
        builder:
            (context) => SomethingWentWrongDialog(
              errorMessage: state.errorMessage ?? '',
            ),
      );
      context.read<SelectLevelCubit>().errorMakeNull();
    }
  }
}
