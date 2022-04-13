import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../design_system/design_system.dart';
import '../home_bloc/home_bloc.dart';

class FinalDateFieldWidget extends StatelessWidget {
  const FinalDateFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDate = DateFormat('dd/MM/yyyy');

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('End date:'),
            AppButton(
              label: state.finalDate == null ? "select a date" : formatDate.format(state.finalDate!),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: state.finalDate ?? DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  final statusData = selectedDate.compareTo(DateTime.now());

                  if (statusData <= 0) {
                    context.read<HomeBloc>().add(FinalDateChanged(selectedDate));
                    context.read<HomeBloc>().add(SetErrorMessage(''));
                  } else {
                    context.read<HomeBloc>().add(SetErrorMessage('Data final inválida'));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
