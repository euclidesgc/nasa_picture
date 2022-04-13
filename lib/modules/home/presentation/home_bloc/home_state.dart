part of 'home_bloc.dart';

class HomeState {
  final DateTime? initialDate;
  final DateTime? finalDate;
  final String? errorMessage;
  final FormStatus formStatus;
  final bool initialDateIsValid;
  final bool finalDateIsValid;

  HomeState({
    this.initialDate,
    this.finalDate,
    this.errorMessage,
    this.formStatus = const InitialFormStatus(),
    this.initialDateIsValid = false,
    this.finalDateIsValid = false,
  });

  HomeState copyWith({
    DateTime? initialDate,
    DateTime? finalDate,
    String? errorMessage,
    FormStatus? formStatus,
    bool? initialDateIsValid,
    bool? finalDateIsValid,
  }) {
    return HomeState(
      initialDate: initialDate ?? this.initialDate,
      finalDate: finalDate ?? this.finalDate,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
      initialDateIsValid: initialDateIsValid ?? this.initialDateIsValid,
      finalDateIsValid: finalDateIsValid ?? this.finalDateIsValid,
    );
  }
}
