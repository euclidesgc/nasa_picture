import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_system/design_system.dart';
import '../home_bloc/home_bloc.dart';

class FilterFieldWidget extends StatelessWidget {
  const FilterFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: AppTextField(
        hintText: 'Filter by title or date',
        onChanged: (value) {
          context.read<HomeBloc>().add(FilterList(value));
        },
      ),
    );
  }
}
