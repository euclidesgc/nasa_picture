import '../entities/media_entity.dart';

abstract class IHomeRepository {
  /// [initialDate] and [finaldate] must be this format: YYYY-MM-DD
  Future<List<MediaEntity>> getNasaMedia({
    required String initialDate,
    required String finalDate,
  });
}
