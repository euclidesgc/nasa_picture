import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../domain/usecases/get_nasa_media_usecase.dart';
import 'form_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNasaMediaUsecase usecase;

  HomeBloc(this.usecase) : super(HomeState()) {
    on<InitialDateChanged>(initialDateChanged);
    on<FinalDateChanged>(finalDateChanged);
    on<SetErrorMessage>(setErrorMessage);
    on<FormSubmitted>(formSubmitted);
  }

  void initialDateChanged(event, emit) {
    emit(state.copyWith(initialDate: event.initialDate));
  }

  void finalDateChanged(event, emit) {
    emit(state.copyWith(finalDate: event.finalDate));
  }

  void setErrorMessage(event, emit) {
    emit(state.copyWith(errorMessage: event.message));
  }

  void formSubmitted(event, emit) async {
    EasyLoading.show(status: 'Aguarde ...', maskType: EasyLoadingMaskType.black);
    try {
      final result = await usecase(initialDate: state.initialDate!, finalDate: state.finalDate!);
      emit(state.copyWith(formStatus: SuccessFormStatus(result)));
    } on Exception catch (e) {
      emit(state.copyWith(formStatus: FailFormStatus(e)));
      EasyLoading.showError("Erro inesperado!", dismissOnTap: true, duration: const Duration(seconds: 5), maskType: EasyLoadingMaskType.black);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
