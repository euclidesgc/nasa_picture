import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home_bloc/form_status.dart';
import '../home_bloc/home_bloc.dart';

class MediaListWidget extends StatelessWidget {
  const MediaListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.formStatus is SuccessFormStatus) {
          final mediaList = (state.formStatus as SuccessFormStatus).list;
          return Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: mediaList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(mediaList[index].title),
                      subtitle: Text(mediaList[index].date),
                      onTap: () => Modular.to.pushNamed('/detail', arguments: mediaList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        }

        if (state.formStatus is FailFormStatus) {
          return const Text("Falha ao obter dados");
        }
        return const Text("Select a date range and click in Get images");
      },
    );
  }
}
