import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/usecases/get_nasa_media_usecase.dart';
import 'home_bloc/home_bloc.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  final GetNasaMediaUsecase usecase;

  const HomePage({Key? key, required this.usecase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(usecase),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Astronomy Picture of the Day'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      InitialDateFieldWidget(),
                      FinalDateFieldWidget(),
                      SearchButtonWidget(),
                    ],
                  ),
                  const ErrorMessageWidget(),
                  const FilterFieldWidget(),
                  const SizedBox(height: 16),
                ],
              ),
              const MediaListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
