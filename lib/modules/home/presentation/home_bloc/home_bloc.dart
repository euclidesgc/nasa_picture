import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../domain/entities/media_entity.dart';
import '../../domain/usecases/get_nasa_media_usecase.dart';
import 'form_status.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNasaMediaUsecase usecase;

  List<MediaEntity> listMedias = [];

  HomeBloc(this.usecase) : super(HomeState()) {
    on<InitialDateChanged>(initialDateChanged);
    on<FinalDateChanged>(finalDateChanged);
    on<SetErrorMessage>(setErrorMessage);
    on<FormSubmitted>(formSubmitted);
    on<ValidateInitialDate>(validateInitialDate);
    on<ValidateFinalDate>(validateFinalDate);
    on<FilterList>(filterLister);
  }

  void filterLister(FilterList event, emit) {
    List<MediaEntity> myList = [];
    RegExp myRegExp = RegExp('[0-9]');

    if (event.value.startsWith(myRegExp)) {
      myList = listMedias.where((element) => element.date.startsWith(event.value)).toList();
    } else {
      myList = listMedias.where((element) => element.title.contains(event.value)).toList();
    }
    emit(state.copyWith(formStatus: SuccessFormStatus(myList)));
  }

  void initialDateChanged(event, emit) {
    emit(state.copyWith(initialDate: event.initialDate));
    add(ValidateInitialDate());
  }

  void finalDateChanged(event, emit) {
    emit(state.copyWith(finalDate: event.finalDate));
    add(ValidateFinalDate());
  }

  void setErrorMessage(event, emit) {
    emit(state.copyWith(errorMessage: event.message));
  }

  validateInitialDate(event, emit) {
    if (state.initialDate != null && state.initialDate!.compareTo(DateTime.now()) <= 0) {
      emit(state.copyWith(initialDateIsValid: true, finalDate: state.initialDate));
      add(FinalDateChanged(state.initialDate!));
    } else {
      emit(state.copyWith(initialDateIsValid: false));
    }
  }

  validateFinalDate(event, emit) {
    if (state.finalDate != null && state.finalDate!.compareTo(state.initialDate!) >= 0) {
      emit(state.copyWith(finalDateIsValid: true));
    } else {
      emit(state.copyWith(finalDateIsValid: false));
    }
  }

  void formSubmitted(event, emit) async {
    EasyLoading.show(status: 'Aguarde ...', maskType: EasyLoadingMaskType.black);
    try {
      final result = await usecase(initialDate: state.initialDate!, finalDate: state.finalDate!);
      listMedias = result;

      emit(state.copyWith(formStatus: SuccessFormStatus(result)));
    } on Exception catch (e) {
      emit(state.copyWith(formStatus: FailFormStatus(e)));
      EasyLoading.showError("Erro inesperado!", dismissOnTap: true, duration: const Duration(seconds: 5), maskType: EasyLoadingMaskType.black);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
