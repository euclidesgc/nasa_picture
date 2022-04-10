import '../entities/media_entity.dart';
import '../repositories/i_home_repository.dart';

class GetNasaMediaUsecase {
  final IHomeRepository repository;

  GetNasaMediaUsecase({required this.repository});

  Future<List<MediaEntity>> call({required DateTime initialDate, required DateTime finalDate}) async {
    final String start = initialDate.toIso8601String().substring(0, 10);
    final String end = finalDate.toIso8601String().substring(0, 10);

    try {
      return await repository.getNasaMedia(initialDate: start, finalDate: end);
    } catch (e) {
      rethrow;
    }
  }
}
