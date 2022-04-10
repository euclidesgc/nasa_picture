import '../models/media_model.dart';

abstract class IHomeDatasource {
  Future<List<MediaModel>> getNasaMedia({
    required String initialDate,
    required String finalDate,
  });
}
