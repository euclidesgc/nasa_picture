import '../../domain/entities/media_entity.dart';
import '../../domain/repositories/i_home_repository.dart';
import '../datasources/i_home_datasource.dart';

class HomeRepository implements IHomeRepository {
  final IHomeDatasource datasource;

  HomeRepository({required this.datasource});

  @override
  Future<List<MediaEntity>> getNasaMedia({required String initialDate, required String finalDate}) async {
    try {
      final response = await datasource.getNasaMedia(initialDate: initialDate, finalDate: finalDate);
      final medias = response.map<MediaEntity>((e) => e.toMediaEntity()).toList();
      return medias;
    } catch (e) {
      rethrow;
    }
  }
}
