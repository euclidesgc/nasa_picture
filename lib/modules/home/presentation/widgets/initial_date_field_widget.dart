import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../design_system/design_system.dart';
import '../home_bloc/home_bloc.dart';

class InitialDateFieldWidget extends StatelessWidget {
  const InitialDateFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    final formatDate = DateFormat('dd/MM/yyyy');

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Start date:'),
            AppButton(
              label: state.initialDate == null ? "select a date" : formatDate.format(state.initialDate!),
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: state.initialDate ?? DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime.now(),
                );
                context.read<HomeBloc>().add(InitialDateChanged(selectedDate!));
              },
            ),
          ],
        );
      },
    );
  }
}
