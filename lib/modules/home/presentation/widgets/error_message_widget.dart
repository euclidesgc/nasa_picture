import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_system/tokens/app_colors.dart';
import '../home_bloc/home_bloc.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Text(
          state.errorMessage ?? '',
          style: const TextStyle(color: AppColors.error, fontSize: 10),
        );
      },
    );
  }
}
