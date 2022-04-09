import '../entities/media_entity.dart';

abstract class IHomeRepository {
  Future<List<MediaEntity>> getNasaMedia({
    required DateTime initialDate,
    required DateTime finalDate,
  });
}
