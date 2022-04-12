import '../../../domain/entities/media_entity.dart';

abstract class FormStatus {
  const FormStatus();
}

class InitialFormStatus extends FormStatus {
  const InitialFormStatus();
}

class SubmittingFormStatus extends FormStatus {
  const SubmittingFormStatus();
}

class SuccessFormStatus extends FormStatus {
  final List<MediaEntity> list;

  const SuccessFormStatus(this.list);
}

class FailFormStatus extends FormStatus {
  final Exception? exception;

  const FailFormStatus(this.exception);
}
