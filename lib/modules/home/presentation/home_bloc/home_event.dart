part of 'home_bloc.dart';

abstract class HomeEvent {}

class InitialDateChanged extends HomeEvent {
  final DateTime initialDate;

  InitialDateChanged(this.initialDate);
}

class FinalDateChanged extends HomeEvent {
  final DateTime finalDate;

  FinalDateChanged(this.finalDate);
}

class ValidateInitialDate extends HomeEvent {}

class ValidateFinalDate extends HomeEvent {}

class FilterList extends HomeEvent {
  final String value;

  FilterList(this.value);
}

class SetErrorMessage extends HomeEvent {
  final String? message;

  SetErrorMessage(this.message);
}

class FormSubmitted extends HomeEvent {}
