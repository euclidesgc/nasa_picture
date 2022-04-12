part of 'home_bloc.dart';

class HomeState {
  final DateTime? initialDate;
  final DateTime? finalDate;
  final String? errorMessage;
  final FormStatus formStatus;

  HomeState({
    this.initialDate,
    this.finalDate,
    this.errorMessage,
    this.formStatus = const InitialFormStatus(),
  });

  HomeState copyWith({
    DateTime? initialDate,
    DateTime? finalDate,
    String? errorMessage,
    FormStatus? formStatus,
  }) {
    return HomeState(
      initialDate: initialDate ?? this.initialDate,
      finalDate: finalDate ?? this.finalDate,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  bool get initialDateIsValid {
    if (initialDate != null && initialDate!.compareTo(DateTime.now()) <= 0) {
      return true;
    } else {
      return false;
    }
  }

  bool get finalDateIsValid {
    if (finalDate!.compareTo(initialDate!) >= 0) {
      return true;
    } else {
      return false;
    }
  }
}
