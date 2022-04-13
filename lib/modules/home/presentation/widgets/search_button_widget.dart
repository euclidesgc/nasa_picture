import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_system/design_system.dart';
import '../home_bloc/home_bloc.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppButton.secondary(
          label: 'Get images',
          onPressed: () {
            if (state.initialDateIsValid && state.finalDateIsValid) {
              context.read<HomeBloc>().add(FormSubmitted());
            }
          },
        );
      },
    );
  }
}
