import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart' hide ModularWatchExtension;
import 'package:intl/intl.dart';

import '../../design_system/design_system.dart';
import '../domain/usecases/get_nasa_media_usecase.dart';
import 'home_bloc/bloc/form_status.dart';
import 'home_bloc/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final GetNasaMediaUsecase usecase;

  HomePage({Key? key, required this.usecase}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final formatDate = DateFormat('dd/MM/yyyy');

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
                  Form(
                    key: _formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _initialDateField(),
                        _finalDateField(),
                        _searchButton(),
                      ],
                    ),
                  ),
                  _errorMessage(),
                  _searchField(),
                  const SizedBox(height: 16),
                ],
              ),
              _mediaList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mediaList() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.formStatus is SuccessFormStatus) {
          final mediaList = (state.formStatus as SuccessFormStatus).list;
          return Expanded(
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
          );
        }

        if (state.formStatus is FailFormStatus) {
          return const Text("Falha ao obter dados");
        }
        return const Text("Selecione um período e click em buscar");
      },
    );
  }

  Widget _errorMessage() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Text(
          state.errorMessage ?? '',
          style: const TextStyle(color: Colors.red, fontSize: 10),
        );
      },
    );
  }

  Widget _searchField() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const AppTextField(
        hintText: 'Pesquisar',
      ),
    );
  }

  Widget _initialDateField() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Data inicial:'),
            ElevatedButton(
              child: Text(state.initialDate == null ? "Data inicial" : formatDate.format(state.initialDate!)),
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: state.initialDate ?? DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime.now(),
                );

                if (selectedDate != null) {
                  final statusData = selectedDate.compareTo(DateTime.now());

                  if (statusData <= 0) {
                    context.read<HomeBloc>().add(InitialDateChanged(selectedDate));
                    context.read<HomeBloc>().add(FinalDateChanged(selectedDate));
                    context.read<HomeBloc>().add(SetErrorMessage(''));
                  } else {
                    context.read<HomeBloc>().add(SetErrorMessage('Data inicial inválida'));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _finalDateField() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Data final:'),
            ElevatedButton(
              child: Text(state.finalDate == null ? "Data final" : formatDate.format(state.finalDate!)),
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

  Widget _searchButton() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SizedBox(
          width: 100,
          child: ElevatedButton(
            child: const Text("Buscar"),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                context.read<HomeBloc>().add(FormSubmitted());

                if (state is SuccessFormStatus) {
                  // da mensagem de sucesso
                }

                if (state is FailFormStatus) {
                  // da mensagem de erro
                }
              }
            },
          ),
        );
      },
    );
  }
}
